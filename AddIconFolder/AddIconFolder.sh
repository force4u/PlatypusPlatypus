#!/bin/bash
#----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
#        com.cocolog-nifty.quicktimer.icefloe
#----+----1----+----2----+-----3----+----4----+----5----+----6----+----7



if [ -z "$@" ]
then
echo "↓このウィンドにフォントファイルをドロップ↓"
exit
fi



theIconFile=`osascript  <<-'END'
use AppleScript version "2.4"
use framework "Foundation"
use scripting additions
on run 
set listIcon to {"orange.icns", "aqua.icns", "blue.icns", "darkblue.icns", "generic.icns", "gray.icns", "green.icns", "pink.icns", "red.icns", "syft.icns", "violet.icns", "white.icns", "yellow.icns"} as list
activate
set replyIcon to (choose from list listIcon with title "アイコンを選んでください" with prompt "選んでください" without multiple selections allowed and empty selection allowed) as text
Return replyIcon
end run 
END`

echo "選んだアイコン"  $theIconFile

for objFolder in "$@"
do
theFilePath=$(echo "$objFolder")
theFolderName=$(echo $(basename -- "$objFolder"))
theFileBseName="${theFolderName%.*}"
theFileDir="${objFolder:0:${#objFolder} - ${#theFolderName}}"

#####コマンドへのパス
theAppDir=$(cd $(dirname $0); pwd)
theBinPath=$theAppDir"/seticon"
####アイコンへのパス
theIconPath=$theAppDir"/"$theIconFile

##########
echo "theAppDir：" $theAppDir
echo "ファイルパス：" $theFilePath
echo "ファイル名：" $theFileName
echo "ベースファイル名：" $theFileBseName
echo "ディレクトリ："  $theFileDir
##########
echo "選んだアイコン"  $theIconFile
echo "コマンドへのパス"  $theBinPath
echo "アイコンへのパス"  $theIconPath

theCommandText="\"$theBinPath\" \"$theIconPath\" \"$theFilePath\""
echo $theCommandText
eval $theCommandText


done

if [ ! $# -eq "0" ]; then
    echo "Done processing $# Folder"
else
    echo "Do Nothing"
fi





exit