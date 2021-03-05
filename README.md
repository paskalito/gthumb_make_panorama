# gthumb_make_panorama

### Install / Update

#### Dependencies
The Following Programs must be Installed (Install them from your Pakage manager)
- Hugin


#### Install the Script
````
cd /tmp && wget https://raw.githubusercontent.com/paskalito/gthumb_make_panorama/main/gthumb_make_panorama.sh && sudo chmod +x gthumb_make_panorama.sh && sudo mv -f gthumb_make_panorama.sh /usr/local/bin/gthumb_make_panorama.sh
````
#### Setup the Custom Script in gthumb
1. Open gthumb
2. In the Top Bar click
3. Toolbar > Personalize... > New

Name: `Make Panorama`

Command: `mkdir -p /tmp/gthumb-make-panorama && cp %F /tmp/gthumb-make-panorama && paplay /usr/share/sounds/freedesktop/stereo/complete.oga && sh /usr/local/bin/gthumb_make_panorama.sh %P`

Keyboardshortcut: `as you like :D (highly recomended)`

4. Save > Ok > Happy Panorama Making!

### Usage
1. Select any Amount of Pictures shot with an Overlay
2. Go to **Toolbar** and click **Make Panorama** (Or use you **Shortcut**)
3. Wait for the finished Panorama to appear on Bottom of your Picture Folder
