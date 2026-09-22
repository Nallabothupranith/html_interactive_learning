# HTML Interactive Learning

Interactive, browser-based classroom activities for school learning. The root
homepage reads the generated `list.json` catalog and opens available activity
variations inside a responsive iframe.

## Ideas
Refer below links for Ideas
- https://ncert.nic.in/science-laboratory-manual.php?ln=en
- https://ncert.nic.in/school-kits-and-lab-manual.php?ln=en
- https://cbseacademic.nic.in/web_material/QuestionBank/ClassX/MathsX.pdf

## Contributing Activities

Most activity folders are still missing an HTML implementation. Pick one whose
`activity.md` has no `paths` list, then build a self-contained `index.html` in
the same folder.

Good activities should be useful for both teachers and students:

- Make the core concept visible, manipulable, or playful.
- Give teachers a clear way to guide discussion, demonstration, or group work.
- Give students something to try, predict, test, compare, or explain.
- Keep instructions short and on-screen controls obvious.
- Work well on phones, tablets, and classroom PCs.
- Prefer creative interaction over static notes: simulations, quizzes, puzzles,
  drag-and-drop tasks, visual experiments, games, or guided investigations.
- Keep the activity lightweight and runnable with plain HTML/CSS/JavaScript.

## Project Structure

```text
.
├── index.html
├── list.json                         # generated locally; ignored by Git
├── scripts/
│   └── generate_catalog.rb
└── activities/
    ├── food-detectives/
    │   ├── activity.md
    │   └── index.html
    └── pythagoras/
        ├── activity.md
        ├── index.html
        └── 3d/
            └── index.html
```

## Activity Metadata

Each activity is described by an `activity.md` file beside its HTML file. The
YAML front matter supplies catalog fields, while the Markdown body supplies the
activity description.

```markdown
---
order: 1
class: VI
subject: Science
topic: Food
title: Example Activity
paths:
  - label: Interactive
    path: index.html
---

Describe what learners do and what concept the activity demonstrates.
```

Paths are relative to `activity.md`, so the usual path is simply `index.html`.
For multiple variations, add more entries:

```yaml
paths:
  - label: 2D Challenge
    path: index.html
  - label: 3D Interactive
    path: 3d/index.html
```

Use short, student-friendly labels. External `https://` paths are also
supported. Do not edit or commit `list.json`; it is generated from all
`activity.md` files.

## Local Build and Preview

Ruby is the only build requirement. From the repository root, generate the
catalog and start a local web server:

```sh
ruby scripts/generate_catalog.rb
python3 -m http.server 8000
```

Open `http://127.0.0.1:8000/`. Run the generator again whenever an
`activity.md` file changes, then refresh the browser.

To validate metadata without changing the catalog:

```sh
ruby scripts/generate_catalog.rb --validate
```

To regenerate and verify the catalog locally:

```sh
ruby scripts/generate_catalog.rb
ruby scripts/generate_catalog.rb --check
```

Pull requests generate the catalog to validate all metadata and local paths.
After a change reaches `main`, GitHub Actions generates `list.json` inside a
GitHub Pages artifact and deploys that artifact. The generated file is never
committed to Git.

## GitHub Pages Deployment

The repository must use **GitHub Actions** as its Pages publishing source. An
administrator can select it under **Settings → Pages → Build and deployment →
Source**. The `Deploy GitHub Pages` workflow then builds and publishes the site
on every push to `main`; no generated catalog commit is required.

## Suggested Workflow

1. Choose an `activity.md` file that has no `paths` list.
2. Plan the learner experience: what should the student notice, do, and discuss?
3. Add `index.html` beside that metadata file.
4. Add a `paths` entry to `activity.md`.
5. Build and test the activity at phone, tablet, and desktop widths.
6. Build and run a local server from the project root:

```sh
ruby scripts/generate_catalog.rb
python3 -m http.server 8000
```

Then open `http://127.0.0.1:8000/` and confirm the homepage can filter, find,
and launch your activity.

## Fork and Pull Request

Contributions are welcome through pull requests.

Before starting, please create a GitHub issue for the activity you want to build,
or comment on an existing issue to claim it. Mention the class, subject, topic,
and activity name from `activity.md`. This helps contributors avoid working on the
same activity at the same time.

1. Fork this repository to your own GitHub account.
2. Clone your fork locally.
3. Create or claim a GitHub issue for the activity.
4. Create a new branch for your activity:

```sh
git checkout -b add-my-activity
```

5. Add the activity files and update `activity.md`.
6. Test the homepage and the activity locally.
7. Commit your changes with a clear message:

```sh
git add activities/my-activity/
git commit -m "Add interactive activity for my topic"
```

8. Push your branch to your fork:

```sh
git push origin add-my-activity
```

9. Open a pull request against the main repository.

In your pull request, briefly mention the class, subject, topic, activity name,
what students do in the activity, and any variations you added.

## Design Notes

Design for real classrooms. A teacher may be projecting the activity to a class,
while students may be using small screens in groups. Make controls large enough,
feedback immediate, and text readable. Be creative, but keep the learning goal
clear.
