#!/bin/bash

PROJECT_NAME="starry_night"
EXPORT_PATH="../$PROJECT_NAME-export"
GODOT_PATH_EXE="../../godot_gd/godot-gd"

function make_build() {
	local BUILD_PATH=$EXPORT_PATH"/"$1
	mkdir $BUILD_PATH
	$GODOT_PATH_EXE --verbose --export $2 $BUILD_PATH"/"$3

	zip --junk-paths $EXPORT_PATH"/"$PROJECT_NAME"_"$1".zip" $BUILD_PATH/*
}

if [ ! -d $EXPORT_PATH ]
then
	mkdir $EXPORT_PATH
else
	rm -r $EXPORT_PATH/*
fi

git checkout main

make_build "mac" "Mac_OSX"  $PROJECT_NAME".zip"
make_build "linux" "Linux_X11" $PROJECT_NAME".x86_64"
make_build "windows" "Windows_Desktop" $PROJECT_NAME".exe"

git checkout html_export

make_build "html" "HTML5" "index.html"

git checkout main
