# Scripts

A collection of bash/fish/py scripts for my personal use. Maybe, you'll find something useful here, or, maybe not.

### battery-health.sh

Shows the ratio (in percentage) between Battery's maximum charge capacity now and Battery's maximum charge capacity when it was new

### battery-percentage.sh

Shows how much battery is charged (in percentage)

### clean-with-gitignore.sh

Clean current working directory (delete files in it) according to the list found in `.gitignore` file in the current working directory
**Note:** May not work with complex `.gitignore` files

### edit-gdm-custom-css

Edit `/etc/gdm-tools/custom.css` file and then 

1. Re-apply GDM theme
2. Re-extract GDM theme
3. Apply `custom.css` to the extracted theme
4. If gnome shell theme was set to `default-extracted`, re-apply it too

**Depends on:** [gdm-tools](https://github.com/realmazharhussain/gdm-tools.git), sudo or doas, gsettings, nano or vim or vi,  `/usr/share/libalpm/scripts/extract-gdm-theme`

### enable-chaotic-aur.sh

Enable chaotic-aur repository on Arch-like/Arch-based distributions

### fish-prompts.fish

Alternative to the fish command `fish_config prompt show`. I wrote it when I didn't know `fish_config` command could do the same thing.

### getints.py

Get integers that represent the string provided as 1st argument.

Usage: `getints.py <string> [size]`

**Note:** `[size]` is optional and represents size of each int in bytes

### git-version.sh

Make a version number for currently open git repository

### gitapps-status.fish

Print `fish_prompt` and `git status` for each git repository in `/mnt/Data/gitapps/` directory.

### hexprint.py

Print contents of files in hex format (and also in ASCII)

### icon-names.sh

`icon-names.sh subdir querry` searches for a sub-folder named `subdir` in all icon themes installed on `/usr/share/icons` for all files that contain the word `querry`.

That is, running `icon-names.sh mimetypes appimage` will list all mimetypes containing the word `appimage`  (ignoring the extension) which have an icon installed on the system.

### is-number

Check if provided arguments are numbers or not
**Example Usage:** `if is-number $1; then echo $1 is a number; fi`

### update-appimages

Use `/mnt/Data/Apps+/Linux/AppImages/appimageupdatetool-x86_64.AppImage` to update all AppImages in `/mnt/Data/Apps+/Linux/AppImages` and `/mnt/Data/Apps+/Linux/AppImages/installed` directories.

**Note:** `/mnt/Data` is mount-point of my `Data` partition.

### update-aur-git-pkgs

Update all of my `*-git` AUR packages to the latest version.

### update-aur-pkg

Update my AUR package (determined by `$PWD` or first argument ) to the latest version.

### update-dynamic-wallpaper.sh

Create/update a GNOME-style dynamic background from the pictures in `~/Pictures/Wallpapers` directory so that I get a different wallpaper everyday but from my collection instead of something on the Internet e.g. bing, reddit, etc.

### zenity-sudo-askpass

A graphical password dialog for sudo (using zenity)

