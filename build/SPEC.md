# How Spazio is built

A tiny local server serves one page; the page reads and writes small JSON files; Claude writes into the same files with a command. Nothing leaves the computer. Python 3.9+, standard library only.

## Files (all created in phase 1)
```
spazio/
  server.py         the local server
  index.html        the whole app: HTML, CSS and JavaScript in one file
  Brygada1918.ttf   title font, copied from references/fonts/ (with its OFL license file)
  config.json       name, language, port, theme
  steps.json        next steps
  log.json          what happened
  projects.json     projects and their status
  spazio.py         the command Claude and the person use
  spazio            tiny shell wrapper: exec python3 "$(dirname "$0")/spazio.py" "$@"   (chmod +x; spazio.cmd on Windows)
  start.command     double-click to start on Mac (chmod +x); start.bat on Windows
```

## Data shapes
```json
// config.json
{ "name": "Spazio", "owner": "Alex", "lang": "en", "port": 8765, "theme": "dark" }

// steps.json
{ "steps": [ { "id": "s-20261018-0915", "title": "Draw the last twelve icons", "why": "The set feels finished at sixty",
               "who": "you", "status": "todo", "result": "", "open": ["projects/icons"] } ] }
// who: you | claude | together     status: todo | doing | done
// id: "s-" + date and time of creation (unique, never reused)
// open: files or folders this step is about; the page shows them as small links the person can copy

// log.json (newest last; the page shows newest first)
[ { "ts": "2026-10-04T09:20:00", "who": "claude", "text": "Listing draft for the habit tracker" } ]

// projects.json
[ { "id": "icons", "name": "Soft icons", "status": "building", "next": "Draw the last twelve" } ]
```

## Server (`server.py`)
- Reads the port from `config.json` (default 8765).
- `GET /` serves `index.html`; `GET /Brygada1918.ttf` serves the font. `GET /api/state` returns config, steps, the last 200 log lines and projects in one JSON.
- `POST /api/step` (add or update by id), `POST /api/log`, `POST /api/project` (add or update by id). Write files atomically: write a temp file, then `os.replace`.
- Listen on `127.0.0.1` only. Answer 403 when `Host` is not `127.0.0.1:<port>` or `localhost:<port>`, and to any POST whose `Origin` is present and not one of those two: other web pages can't talk to it.

## Start file (`start.command`)
`cd` into its own folder, start `python3 server.py` in the background, wait until `/api/state` answers (try every 0.3 s, up to 10 s), then `open -a "Google Chrome" http://localhost:<port>` (or `open` if Chrome is missing). If the server already answers, just open the page. The first time macOS may block it: right-click, Open, Open. `start.bat` does the same with `python` or `py -3` and `start ""`.

## The command (`spazio.py`)
```
spazio/spazio log "what you did"
spazio/spazio step "title" "why" you|claude|together     (prints the new id)
spazio/spazio done <id> "result in one line"
spazio/spazio list                                        (open steps with ids)
```
It edits the JSON files directly, so it works with the server off.

## The page (`index.html`)
- Left: a narrow sidebar with the Spazio name, today's priority and the menu (Today, Steps, Projects, Log). Right: the content in large soft cards, a huge serif title on each page.
- Theme tokens from STYLE.md as CSS variables on `html[data-theme]`; the theme comes from localStorage, else `config.json`.
- Top right: the theme switch (half circle, from phase 5). Bottom: the command bar: typing text and Enter adds a step for "you"; `/` focuses it.
- Refresh `/api/state` every 10 seconds so what Claude writes appears by itself.
