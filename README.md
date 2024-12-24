# gthumb_make_panorama

An Easy and superconvenient way to Stitch together Panoramashots out of Gthumb.

![yolo4](https://user-images.githubusercontent.com/8012793/110212413-81f0ba80-7e9b-11eb-9024-db8e10de31d7.gif)


### Install / Update

#### Dependencies
The Following Programs must be Installed (Install them from your Pakage manager)
- hugin (http://hugin.sourceforge.net)
- gthumb (https://gitlab.gnome.org/GNOME/gthumb)
- Exiftool (https://exiftool.org/) (optional for Preservation of Metadata in Panoramafile)


#### 1 Install/Update the Script
Open a **Terminal**, **Paste** the Following **Code** and hit **Enter**, **Type** in your **Password** when are asked to
````
cd /tmp && wget https://raw.githubusercontent.com/paskalito/gthumb_make_panorama/main/gthumb_make_panorama.sh && sudo chmod +x gthumb_make_panorama.sh && sudo mv -f gthumb_make_panorama.sh /usr/local/bin/gthumb_make_panorama.sh
````
_In Case you want to Update to a newer Version of the Script just run this Command again, and you are good to go_

#### 2 Setup the Custom Script in gthumb
1. Open gthumb
2. In the Top Bar click
3. Toolbar > Personalize... > New

Name: `Make Panorama`

Command: `mkdir -p /tmp/gthumb-make-panorama && cp -p %F /tmp/gthumb-make-panorama && paplay /usr/share/sounds/freedesktop/stereo/complete.oga & sh /usr/local/bin/gthumb_make_panorama.sh %P`

Keyboardshortcut: `as you like :D (highly recomended)`

4. Save > Ok > Happy Panorama Making!

### Usage
1. Select any Amount of Pictures shot with an Overlay
2. Go to **Toolbar** and click **Make Panorama** (Or use you **Shortcut**)
3. Wait for the finished Panorama to appear on Bottom of your Pictures Folder (in gthumb)
