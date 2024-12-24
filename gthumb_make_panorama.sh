# Custom Command to put into gthumb
# mkdir -p /tmp/gthumb-make-panorama && cp -p %F /tmp/gthumb-make-panorama && paplay /usr/share/sounds/freedesktop/stereo/complete.oga & sh /usr/local/bin/gthumb_make_panorama.sh %P


if hash pto_gen 2>/dev/null; then

	# Create a Folder in /tmp and cd into it
	mkdir /tmp/gthumb-make-panorama
	cd /tmp/gthumb-make-panorama
	
	# Set A Variabel for a Unique FolderName
	NOW=$(date +"%Y-%m-%d %H:%M:%S")
	# Create that Folder
	mkdir "$NOW"
	# Wait in case files are still Copying // Workaround because apparently cp does not actually wait till finished.
	sleep 2
	# Move all the Pictures into that Folder
	mv *.* "$NOW"
	# cd into that Folder
	cd "$NOW"

	# get the name of the Oldest Picture
	filename=$(ls -tNr1 | tail -1)

	# Start with the creation of the Panorama
	# source / credits : http://wiki.panotools.org/Panorama_scripting_in_a_nutshell#Why_would_you_do_that.3F

# open flock for multiple commands - so only one panorama gets assembled at a time
(
 flock 9 || exit 1

    notify-send 'Panorama started!' -u normal

	nice -n 19 pto_gen * -o project.pto

	nice -n 19 cpfind --multirow -o project.pto project.pto

	nice -n 19 celeste_standalone -i project.pto -o project.pto

	# not working
	# ptoclean -v --output project.pto project.pto

	nice -n 19 autooptimiser -a -l -s -o project.pto project.pto

	nice -n 19 pano_modify -o project.pto --center --straighten --canvas=AUTO --crop=AUTO project.pto

	nice -n 19 nona -m TIFF_m -o project project.pto

	nice -n 19 enblend -o project.jpg *.tif


	if hash exiftool 2>/dev/null; then
		#https://photo.stackexchange.com/questions/47778/how-can-i-copy-all-meta-tags-other-than-the-thumbnail-from-a-source-jpg-to-a-d

		# Copy Metadata from oldest Panorama Picture into Panorama, without Image With and Height, and Thumbnail since its diffrent in the panorama.
		exiftool -TagsFromFile "${filename}" "-all:all>all:all" "project.jpg" -ExifImageWidth= -ExifImageHeight= -ThumbnailImage= -overwrite_original -m
		#alternativcommand > working weiss nicht wies mit geo ist.
		#exiftool -TagsFromFile "${filename}" -XMP:All= "project.jpg" -ExifImageWidth= -ExifImageHeight= -ThumbnailImage= -overwrite_original -m

	else
		echo WARNING: Could not find Exiftool Exiftool is needed to preserve Metadata from Original Image in the Panorama file. >&2
		echo Exiftool needs to installed and in standardpath for Exifdata Presevation >&2
		notify-send 'WARNING: Could not find Exiftool' 'Exiftool is needed to preserve Metadata from Original Image in the Panorama file.
	> Please install it and try again.' -u critical -i face-worried
	

	fi
	
	# Set Modification and access time equal to input file
	touch -r "${filename}" "project.jpg"

	# Copy the Finished Panorama Back to the Original Path of the Pictures.
	cp -p project.jpg "$1"/"${filename%.*}"_panorama-"$NOW".jpg
   
	notify-send 'Panorama Finished' 'Check it out!' -u normal -i "$1"/"${filename%.*}"_panorama-"$NOW".jpg

) 9>/tmp/gthumb-make-panorama.lockfile
# close flock

	# Delete our Temporary Workfolder
	rm -rf ../"$NOW"
else
	echo ERROR: Could not find hugin >&2
	echo hugin needs to installed and in standardpath for make_panorama to work >&2
		
	notify-send 'ERROR: Could not find hugin' 'hugin needs to installed and in standardpath for make_panorama to work!
	> Please install it and try again.' -u critical -i face-worried
	# delete the Copied Files
	rm /tmp/gthumb-make-panorama/*.*
fi
