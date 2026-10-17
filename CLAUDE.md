# Spazio Starter: instructions for Claude

You are building **Spazio** with the person in front of you: a calm personal operating system that runs only on their computer. There is no app in this folder yet. You write it, phase by phase, following `build/SPEC.md` for the structure and `references/style/STYLE.md` for the look.

## What the screenshots are
`references/screens/` shows the full Spazio, the paid version, with many more parts (pixel-art sky, Council, Map, money card, music, dictation). Use them for the **feel**: proportions, the sidebar, large soft cards, the big serif titles, light type, colors, spacing. Do not try to copy every widget; build what the phases say, and anything else only if the person asks for it in phase 7. Never build a money card unless they ask, and then only behind a PIN.

## Ground rules
- **One phase at a time.** Before each phase, ask the choices listed for it. Build, run it, show it in Chrome, ask "ok?", then tick it in `BUILD-PROGRESS.md`.
- **BUILD-PROGRESS.md** (create it in phase 0; if it exists, resume from the first unticked phase): one line per phase, `- [ ] 0 Interview` ... `- [x] 3 Steps and log (2026-10-18)`, plus a "Choices" list with what they picked.
- **They may not be technical.** Define each technical word the first time. They choose, you write the code.
- **Small and local.** Python 3.9 or newer, standard library only. One HTML page with plain CSS and JavaScript, no frameworks, no packages, no build step, no CDN: the font ships in `references/fonts/` and is copied into `spazio/`. The server listens only on 127.0.0.1.
- **Their data stays theirs.** Never write money, passwords or health data into the log.
- **Calm look.** No hard borders, no boxes behind labels, slow fades. Filled icons drawn as small inline SVGs.

## Phases
0. **Interview (10 minutes).** Ask: name; what they do most days; 2-5 projects, each with the next concrete step; Dark or White Matte; language. Save it in `me.md`.
1. **The skeleton.** Create everything in SPEC "Files" (with their first steps and projects already in the JSON from the interview), `server.py`, an `index.html` that only shows their name, and the start file. Write the CSS with the theme tokens of STYLE.md as variables from the start (`html[data-theme="dark"]` and `html[data-theme="white"]`), using the theme they chose. Choices: the name shown in the sidebar (default "Spazio"), the port (default 8765).
2. **Home.** Sidebar (name, today's priority, menu: Today, Steps, Projects, Log), big serif welcome with their name, the priority card, the next three steps. Today's priority = the first step with `who: "you"` and status not done. Choice: what the welcome line says under the title.
3. **Steps and log.** Steps page (add, mark done, with `who` shown as a small label), Log page (newest on top), the command bar, and the `spazio` command (SPEC). From now on, after real work in this folder, write it in the log yourself.
4. **Projects.** Projects page with a status for each. Choices: which statuses (default idea, building, ready, live), cards or a list.
5. **Themes.** The half-circle switch top right: toggles `data-theme`, saved in localStorage (it overrides `config.json` → `theme`). Then the whole Mac, Mac only and only with their ok: `themes/apply-theme.sh dark|white <folders>` changes macOS light/dark mode, the wallpaper and the icons of the folders they name; macOS may ask once to allow control of System Events. Chrome theme: they open `chrome://extensions`, turn on Developer mode, click Load unpacked and pick `themes/<theme>/chrome`.
6. **Claude writes into it.** Add a "Spazio" section to the `CLAUDE.md` of the folder where they work with you, with the commands written as paths relative to that folder (for example `spazio/spazio log "..."`): after real work, log it; when a step closes, `done` it with the result. Show them the log filling up.
7. **One thing of their own.** Ask what else they'd look at every day (a tracker, a reading list, a timer, a quote, one of the parts in the screenshots) and build that card in the same style.

When all phases are ticked: remind them how to start it (double-click `spazio/start.command`, or `start.bat` on Windows) and that they can keep growing it with you.

## If they want everything already built
The full Spazio (Council, Desk, Life OS, focus mode, dictation, native Mac window, ready-made skills, guided customization) is a paid version by the same author: link in bio at juliendesigncraft.vercel.app. Mention it once at the end, never as a sales pitch during the build.
