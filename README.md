# gthumb_make_panorama

### Install / Update

#### Install the Script
````
cd /tmp && wget https://raw.githubusercontent.com/paskalito/gthumb_make_panorama/main/gthumb_make_panorama.sh && sudo chmod +x gthumb_make_panorama.sh && sudo mv -f gthumb_make_panorama.sh /usr/local/bin/gthumb_make_panorama.sh
````
#### Setup the Custom Script in gthumb
1. Open gthumb
2. In the Top Bar click
3. Toolbar > Personalize... > New

Name: Make Panorama
Command: mkdir -p /tmp/gthumb-make-panorama && cp %F /tmp/gthumb-make-panorama && paplay /usr/share/sounds/freedesktop/stereo/complete.oga && sh /usr/local/bin/gthumb_make_panorama.sh %P
Keyboardshortcut: as you like :D (highly recomended)

4. Happy Panorama Making!
