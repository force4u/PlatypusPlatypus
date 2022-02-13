#!/bin/bash

numCntFile=1
thePathToMe=$(cd $(dirname $0); pwd)

if [ -z "$@" ]
then
echo "↓このウィンドにフォントファイルをドロップ↓"
exit
fi
theNewFileBaseName="Original File Name"

responseText=`/usr/bin/osascript $thePathToMe/dialog.applescript "${theNewFileBaseName}"`

theNewFileBaseName="${responseText}"

for objFile in "$@"
do
theFilePath=$(echo "$objFile")
theFileName=$(echo $(basename -- "$objFile"))
theFileBseName="${theFileName%.*}"
theExeName="${theFileName##*.}"
theFileDir="${objFile:0:${#objFile} - ${#theFileName}}"

echo "ファイルパス：" $theFilePath
echo "ファイル名：" $theFileName
echo "ベースファイル名：" $theFileBseName
echo "拡張子：" $theExeName
echo "ディレクトリ："  $theFileDir

#########
theImageWidth=$(echo `sips --getProperty pixelWidth "$theFilePath"` | cut -f 2 -d ':'| echo `cat`)
echo "イメージ幅：" $theImageWidth
theImageHeight=$(echo `sips --getProperty pixelHeight "$theFilePath"` | cut -f 2 -d ':'| echo `cat`)
echo "イメージ高さ：" $theImageHeight
#########
theMimeType=$(echo `file --mime-type  "$theFilePath"` | cut -f 2 -d ':')
echo "MIME/TYPE：" $theMimeType
#########

numFileNo=`printf "%04d" "$numCntFile" `
echo "ファイル数：" $numCntFile
echo "ファイル番号：" $numFileNo
#########

if [ "${responseText}" == "Original File Name" ]; then
theNewFileBaseName="${theFileBseName}"
else
theNewFileBaseName="${responseText}"
fi
#########
theNewFileName="${theNewFileBaseName}_${numFileNo}_${theImageWidth}x${theImageHeight}.${theExeName}"
echo "新しいファイル名：" $theNewFileName
#########

mv "${theFilePath}" "${theFileDir}${theNewFileName}"

numCntFile=$((numCntFile+1))
done

if [ ! $# -eq "0" ]; then
    echo "Done processing $# images"
else
    echo "Do Nothing"
fi

