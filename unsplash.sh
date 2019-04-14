#!/bin/sh
# Images are taken from the "hell so easy to use (basic) API" of Unsplash, they are totally free for all use.

# The downloaded images are kept in ~/.local/share/unsplashLinux if the following switch is false.
DO_WE_ERASE_FILES=true

# Category of the collection that will have the image randomized choosen from.
CATEGORY=1339090 # 4k
SIZE=5472x3648   # 

WORKDIR=$HOME'/.local/share/unsplashLinux/'

PLAIN_IMAGE="plain"
ENHANCED_IMAGE="enhanced"

RANT=$(date +%s)

# Ensure the folders exists
mkdir -p $WORKDIR
mkdir -p $WORKDIR'old/'

# Check the internet connection before trying update
wget -q --spider http://google.com
if [ $? -eq 0 ]; then
	echo internetIsUp
else
	exit 1
fi

# Image file name
WALLPAPER=${WORKDIR}${PLAIN_IMAGE}'.jpg'
# WALLPAPER=${WORKDIR}${ENHANCED_IMAGE}'.jpg'
OLD_WALLPAPER=${WORKDIR}'old.jpg'

# copying current wallpaper to old wallpaper
cp ${WALLPAPER} ${OLD_WALLPAPER}

# set old wallpaper to gnome bg
gsettings set org.gnome.desktop.background picture-uri 'file://'${OLD_WALLPAPER}
gsettings set org.gnome.desktop.screensaver picture-uri 'file://'${OLD_WALLPAPER}

# Download the image from unsplash to the disk
wget -O ${WALLPAPER} -q https://source.unsplash.com/collection/${CATEGORY}/${SIZE}

# Create the new image with the lab logo.
# composite -gravity center -geometry +100+100 -alpha set `dirname $0`/lab-v1-white.png ${F} ${WALLPAPER}

# Update gnome settings to update the background and screensaver images.
gsettings set org.gnome.desktop.background picture-uri 'file://'${WALLPAPER}
gsettings set org.gnome.desktop.screensaver picture-uri 'file://'${WALLPAPER}

# Removing old files
if $DO_WE_ERASE_FILES
then
  echo removing old wallpaper
else
  cp ${OLD_WALLPAPER} $WORKDIR'old/'$RANT'.jpg'
# else
fi

rm $OLD_WALLPAPER