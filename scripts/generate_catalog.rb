#!/usr/bin/env ruby

require "json"
require "pathname"
require "yaml"

ROOT = Pathname.new(__dir__).join("..").expand_path
CATALOG = ROOT.join("list.json")
METADATA_GLOB = ROOT.join("activities", "**", "activity.md").to_s
REQUIRED_FIELDS = %w[order class subject topic title].freeze

def load_front_matter(path)
  content = path.read(encoding: "UTF-8")
  match = content.match(/\A---\s*\n(.*?)\n---\s*(?:\n|\z)(.*)\z/m)
  raise "#{path.relative_path_from(ROOT)}: missing YAML front matter" unless match

  metadata = YAML.safe_load(match[1], permitted_classes: [], permitted_symbols: [], aliases: false)
  raise "#{path.relative_path_from(ROOT)}: front matter must be a mapping" unless metadata.is_a?(Hash)

  [metadata, match[2].strip]
rescue Psych::SyntaxError => error
  raise "#{path.relative_path_from(ROOT)}: invalid YAML: #{error.message}"
end

def catalog_path(metadata_file, declared_path)
  value = declared_path.to_s.strip
  raise "#{metadata_file.relative_path_from(ROOT)}: activity path cannot be empty" if value.empty?
  return value if value.match?(%r{\Ahttps?://}i)

  target = metadata_file.dirname.join(value).cleanpath
  relative = target.relative_path_from(ROOT).to_s
  if relative == ".." || relative.start_with?("../")
    raise "#{metadata_file.relative_path_from(ROOT)}: activity path leaves the repository"
  end
  raise "#{metadata_file.relative_path_from(ROOT)}: missing activity file #{relative}" unless target.file?

  relative
end

def build_activity(path)
  metadata, body = load_front_matter(path)
  missing = REQUIRED_FIELDS.reject { |field| metadata.key?(field) && !metadata[field].to_s.strip.empty? }
  raise "#{path.relative_path_from(ROOT)}: missing #{missing.join(', ')}" unless missing.empty?
  raise "#{path.relative_path_from(ROOT)}: description body cannot be empty" if body.empty?

  paths = metadata.fetch("paths", [])
  raise "#{path.relative_path_from(ROOT)}: paths must be a list" unless paths.is_a?(Array)

  activity = {
    "class" => metadata["class"].to_s,
    "subject" => metadata["subject"].to_s,
    "topic" => metadata["topic"].to_s,
    "activity_name" => metadata["title"].to_s,
    "activity_details" => body
  }

  unless paths.empty?
    activity["activity_path"] = paths.map do |variation|
      unless variation.is_a?(Hash) && !variation["label"].to_s.strip.empty? && variation.key?("path")
        raise "#{path.relative_path_from(ROOT)}: every path needs a label and path"
      end
      {
        "label" => variation["label"].to_s,
        "path" => catalog_path(path, variation["path"])
      }
    end
  end

  order = begin
    Integer(metadata["order"])
  rescue ArgumentError, TypeError
    raise "#{path.relative_path_from(ROOT)}: order must be an integer"
  end

  [order, activity, path]
end

begin
  records = Dir.glob(METADATA_GLOB).sort.map { |file| build_activity(Pathname.new(file)) }
  raise "No activity.md files found" if records.empty?

  duplicate_orders = records.group_by(&:first).select { |_order, group| group.length > 1 }
  unless duplicate_orders.empty?
    details = duplicate_orders.map do |order, group|
      "#{order}: #{group.map { |record| record[2].relative_path_from(ROOT) }.join(', ')}"
    end
    raise "Duplicate order values: #{details.join('; ')}"
  end

  output = JSON.pretty_generate("activities" => records.sort_by(&:first).map { |record| record[1] }) + "\n"

  case ARGV.first
  when "--validate"
    puts "Validated #{records.length} activity metadata files."
  when "--check"
    raise "list.json is out of date; run ruby scripts/generate_catalog.rb" unless CATALOG.read(encoding: "UTF-8") == output
    puts "list.json is up to date (#{records.length} activities)."
  when nil
    CATALOG.write(output)
    puts "Generated list.json from #{records.length} activity metadata files."
  else
    raise "Unknown option #{ARGV.first.inspect}; use --validate or --check"
  end
rescue StandardError => error
  warn "Catalog generation failed: #{error.message}"
  exit 1
end
