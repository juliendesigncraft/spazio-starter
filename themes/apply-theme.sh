#!/bin/zsh
# Puts the whole Mac in the same theme as Spazio: macOS appearance, wallpaper, folder icons.
#   themes/apply-theme.sh dark                     (Dark Matte)
#   themes/apply-theme.sh white                    (White Matte)
#   themes/apply-theme.sh dark ~/Desktop/Books ~/Desktop/Design   (also restyles these folders)
# A folder gets the icon whose name matches it (Books, Design, Docs, My Space, Study);
# any other folder gets the plain "My Space" icon. Run it again to switch theme.
# Spazio itself follows with its theme switch (half circle, top right).
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
case "$1" in
  dark)  T=dark-matte;  DARK=true ;;
  white) T=white-matte; DARK=false ;;
  *) echo "usage: apply-theme.sh dark|white [folder ...]"; exit 1 ;;
esac
shift
DIR="$HERE/$T"

# 1. macOS light or dark
osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $DARK"

# 2. wallpaper on every screen (copied to ~/Pictures/Spazio so it survives if you move the repo)
mkdir -p ~/Pictures/Spazio
cp "$DIR/wallpaper.png" ~/Pictures/Spazio/$T.png
osascript -e "tell application \"System Events\" to tell every desktop to set picture to POSIX file \"$HOME/Pictures/Spazio/$T.png\""

# 3. folder icons
for f in "$@"; do
  [ -d "$f" ] || { echo "skip (not a folder): $f"; continue; }
  name="$(basename "$f")"
  icon="$DIR/folders/$name.png"; [ -f "$icon" ] || icon="$DIR/folders/My Space.png"
  osascript -l JavaScript -e "ObjC.import('AppKit'); var img = $.NSImage.alloc.initWithContentsOfFile('$icon'); $.NSWorkspace.sharedWorkspace.setIconForFileOptions(img, '$f', 0);" >/dev/null
  echo "icon: $name"
done
killall Finder 2>/dev/null || true
echo "theme: $T"
