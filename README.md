# HTML Interactive Learning

Interactive, browser-based classroom activities for school learning. The root
homepage reads `list.json`, shows the catalog, and opens available activity
variations inside a responsive iframe.

## Contributing Activities

Most activities in `list.json` are still missing an HTML implementation. Pick
one that does not have `activity_path`, create a new folder under `activities/`,
and build a self-contained `index.html` activity for it.

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
├── list.json
└── activities/
    ├── food-detectives/
    │   └── index.html
    └── pythagoras/
        ├── index.html
        └── 3d/
            └── index.html
```

## Updating `list.json`

When you add an activity, update its catalog entry with `activity_path`.

For one variation:

```json
"activity_path": [
  {
    "label": "Interactive",
    "path": "activities/example-activity/index.html"
  }
]
```

For multiple variations:

```json
"activity_path": [
  {
    "label": "2D Challenge",
    "path": "activities/example-activity/index.html"
  },
  {
    "label": "3D Interactive",
    "path": "activities/example-activity/3d/index.html"
  }
]
```

Use short, student-friendly labels. Paths should be relative to the project
root.

## Suggested Workflow

1. Choose a missing activity from `list.json`.
2. Plan the learner experience: what should the student notice, do, and discuss?
3. Create a folder such as `activities/my-activity/index.html`.
4. Build and test the activity at phone, tablet, and desktop widths.
5. Add one or more `activity_path` variations to the matching `list.json` entry.
6. Run a local server from the project root:

```sh
python3 -m http.server 8000
```

Then open `http://127.0.0.1:8000/` and confirm the homepage can filter, find,
and launch your activity.

## Design Notes

Design for real classrooms. A teacher may be projecting the activity to a class,
while students may be using small screens in groups. Make controls large enough,
feedback immediate, and text readable. Be creative, but keep the learning goal
clear.
