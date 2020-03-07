#!/bin/bash
# Images are taken from the "hell so easy to use (basic) API" of Unsplash, they are totally free for all use.

# The downloaded images are kept in ~/.local/share/unsplashLinux if the following switch is false.
DO_WE_ERASE_FILES=true

# Category of the collection that will have the image randomized choosen from.
# CATEGORY=1339090 # 4k
# CATEGORY=3694365 # Gradient Nation
CATEGORY=894 # Earth & Planets
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
	echo "Connectivity verified..."
else
	exit 1
fi

if $DO_WE_ERASE_FILES
then
  rm $WORKDIR$PLAIN_IMAGE'.jpg' 2> /dev/null
else
  cp $WORKDIR$ENHANCED_IMAGE'.jpg' $WORKDIR'old/'$RANT'.jpg'
fi

# Image file name
F=${WORKDIR}${PLAIN_IMAGE}'.jpg'
# WALLPAPER=${WORKDIR}${ENHANCED_IMAGE}'.jpg'
WALLPAPER=${WORKDIR}${PLAIN_IMAGE}'.jpg'

# Download the image from unsplash to the disk
count=0
source="https://images.unsplash.com/source-404?fit=crop&fm=jpg&h=800&q=60&w=1200"
while [[ "$source" =~ "/source-404" ]]; do
	if [[ count -gt 10 ]]; then
		echo "Failed to find an appropriate photo. Sorry! :'("
		exit 2
	fi

	echo "Trying to get photo..."
	source="$(curl -Ls -o /dev/null -w %{url_effective} https://source.unsplash.com/collection/${CATEGORY}/${SIZE})"
	count=$(($count + 1))
done

echo "Downloading $source"
wget -O ${F} -q $source


# Create the new image with the custom logo.
# composite -gravity center -geometry +100+100 -alpha set `dirname $0`/custom-logo.png ${F} ${WALLPAPER}

echo $WALLPAPER

# Update gnome settings to update the background and screensaver images.
if [ "`lsb_release -is`" = "Deepin" ]; then
	gsettings set com.deepin.wrap.gnome.desktop.background picture-uri ${WALLPAPER}
else
	gsettings set org.gnome.desktop.background picture-uri 'file://'${WALLPAPER}
	gsettings set org.gnome.desktop.screensaver picture-uri 'file://'${WALLPAPER}
fi  