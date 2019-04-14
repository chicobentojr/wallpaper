# Wallpaper

This script is a helper for downloading a image from unsplash.com and set it to the background of the gnome.

    $ ./unsplash.sh

## Info

The images are saved in the `$HOME/.local/share/unsplashlinux/` folder.

In order to change the background settings we use the `gsettings` command.

## Configurations

**DO_WE_ERASE_FILES**: true | false

Keep the folder clean, removing the old images.

**CATEGORY**: number

The number of the category extracted from the unsplash.com URL.

**SIZE**: number 'x' number. Ex: 5472x3648

The size of the image that will be downloaded.

## Setting a Cron Job

Open the editor:

```
crontab -e
```

Add the following line to update the wallpaper each hour:

```
0 * * * * <absolute path to script>/unsplash.sh > /dev/null 2>&1
```

> `<absolute path to script>` would be the path in your machine, for example: `/home/chicobentojr/Workspace/wallpaper`

Enjoy :tada:
