# Spazio style guide

The look is fixed: calm, matte, readable, slow. New pieces copy existing ones. Screenshots of every theme are in `../screens/`.

## Themes
The real Spazio has three looks, switched by the half-circle button (top right) and saved in the browser. The starter builds the two matte ones:
- **Notte**: the original, a night sky in pixels over a dark sheet.
- **Dark Matte**: flat blue-graphite, no gradients, light blue accent.
- **White Matte**: the same layout with the light inverted, very light grey, graphite text, blue accent.
When the theme changes, everything changes together: Spazio, macOS, wallpaper, folders, Chrome (`themes/apply-theme.sh`).

## Dark Matte colors
| Token | Hex | Use |
|---|---|---|
| m0 | #16181F | page background |
| m1 | #1B1E26 | cards |
| m2 | #21242D | raised cards, inputs |
| m3 | #282B35 | buttons |
| m4 | #30343F | hover |
| m5 | #3B3F4B | dividers, quiet lines |
| mt1 | #E3E7EF | main text |
| mt2 | #A4ABBA | secondary text |
| mt3 | #8A91A4 | labels |
| ma | #8FC7FF | accent (the Spazio blue) |
| ma2 | #B9DCFF | accent, light |
| ma-on | #12151B | text on the accent |
White Matte uses #F7F8FA for the page, white cards, graphite text and #3B82D0 as the stronger blue for buttons.

## Type
- Titles: **Brygada 1918** (serif, SIL Open Font License, file in `../fonts/`).
- Interface: the system sans (SF on Mac), light weights, tight letter spacing on big numbers.
- Small technical labels only: a mono or pixel face, small and short. Never mono and pixel together, never mono bigger than the text it labels.

## Shapes and motion
- Large soft corners (squircles), no hard borders: separation comes from a slightly lighter surface, not from an outline.
- No boxes behind labels. Over an image, a soft glow behind the text, never a plate.
- Glass only for floating things (the window bar, popovers), with the matte veil on top.
- Motion is slow and quiet: fades and small rises, nothing that bounces.
- Icons are filled, not outlined, in every theme.

## Words
- Short labels, one line per level. Where there's too much text, an icon instead.
- No long dashes, no "·" as separators.
