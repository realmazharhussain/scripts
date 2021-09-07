# Scripts

A collection of bash/fish/py scripts for my personal use. Maybe, you'll find something useful here, or, maybe not.

## fish_prompts.fish

Alternative to the fish command `fish_config prompt show`. I wrote it when I didn't know `fish_config` command could do the same thing.

## gitapps-status.fish

Print `fish_prompt` and `git status` for each git repository in `~/gitapps/` directory.

## icon-names.sh

`icon-names.sh subdir querry` searches for a sub-folder named `subdir` in all icon themes installed on `/usr/share/icons` for all files that contain the word `querry`.

That is, running `icon-names.sh mimetypes appimage` will list all mimetypes containing the word `appimage`  (ignoring the extension) which have an icon installed on the system.

## update-appimages

Use `/mnt/Data/Apps+/Linux/AppImages/appimageupdatetool-x86_64.AppImage` to update all AppImages in `/mnt/Data/Apps+/Linux/AppImages` and `/mnt/Data/Apps+/Linux/AppImages/installed` directories.

**Note:** `/mnt/Data` is mount-point of my `Data` partition.

## update-aur-git

Update my `*-git` AUR package (determined by `$PWD` or first argument ) to the latest version.

## update-dynamic-wallpaper.sh

Create/update a GNOME-style dynamic background from the pictures in `~/Pictures/Wallpapers` directory so that I get a different wallpaper everyday but from my collection instead of something on the Internet e.g. bing, reddit, etc.
