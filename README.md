# Timed Backgrounds

The repository contains build rules for creating dynamic backgrounds compatible
with the [Dynamic Wallpaper
Engine](https://github.com/zzag/plasma5-wallpapers-dynamic).

Available backgrounds:
 * 24 hours (by [Arzamas](https://www.deviantart.com/arzamas/gallery))
 * Akihabara South Exit (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Catherine Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Corporation Hall (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Corporation Street (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Ellie Mansion (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Firewatch (by [Campo Santo](https://blog.camposanto.com/post/138965082204/firewatch-launch-wallpaper-when-we-redid-the) and [\_felics](https://www.reddit.com/r/Firewatch/comments/458ohf/i_made_a_night_version_of_the_launch_wallpaper/))
 * Himitsu House (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Himitsu House Interior (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Island (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Japanese Garden (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Japanese Village House (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Japanese Village House Interior (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * JR Station (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Kagome Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Kumoha 103 Train (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Kyosuke Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Mechanical City (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Metropolis (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Michael Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Mountainside (by [???](https://imgur.com/a/vqb7Q))
 * Old House (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Old House Living and Dining Rooms (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Old House Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Restaurant Interior (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Restaurant Street (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Riverside (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Ryokan Room (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Small Japanese Provincial Town (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Tokyo Street (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Tokyo Street and Club (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Two Queens Cities (by [arsenixc](https://arsenixc.deviantart.com/gallery/))
 * Yunjing City (by [arsenixc](https://arsenixc.deviantart.com/gallery/))

## Installation

### 1. Install the KDE Dynamic Wallpaper Engine

Follow the instructions provided on the [wallpaper
engine](https://github.com/zzag/plasma5-wallpapers-dynamic) site.

### 2. Download backgrounds images

Most of the backgrounds listed above are not licensed for redistribution, so
use the `download_images.sh` script to get them yourself.
```bash
./download_images.sh
```

### 3. Build AVIF files and install

To build and install the backgrounds, run:
```bash
make
sudo make install
```

This assumes that the `kdynamicwallpaperbuilder` binary exists on your system
PATH. If not, check that the [wallpaper
engine](https://github.com/zzag/plasma5-wallpapers-dynamic) was installed
properly.

`make` will build AVIF images for each background. Using `-j` here is
discouraged because AVIF encoding is very resource-hungry, and running multiple
instances in parallel may make your system start thrashing.

`make install` will install the backgrounds in `/usr/share/wallpapers/Timed`.
To specify a different location, use `PREFIX=... make ...` instead.

## Selection

1. Open the 'Configure Desktop and Wallpaper...' right-click menu.
2. Choose 'Dynamic' in the 'Wallpaper type:' combo-box.
3. Select the desired \*.avif file. 

**Note:** To scroll down the window, click the scrollbar or hover the cursor
outside the image gallery.

## Extra

Most of the images are 1080p with a 16-by-9 aspect ratio. Should they be
inadequately crisp, try processing them with an up-scaler.
[waifu2x](https://github.com/nagadomi/waifu2x) is more than adequate. ([Web
service here.](https://waifu2x.udp.jp/))
