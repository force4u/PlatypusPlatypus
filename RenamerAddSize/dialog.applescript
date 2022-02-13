#!/usr/bin/env osascript
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7
#
#
#
#
#        com.cocolog-nifty.quicktimer.icefloe
----+----1----+----2----+-----3----+----4----+----5----+----6----+----7

use AppleScript version "2.4"
use scripting additions
property theNewFileBseName : ""



on run theNewFileBseName
	

	tell application "Finder"
		set aliasPathToMe to (path to me) as alias
		set aliasPathToDir to (container of aliasPathToMe) as alias
		set thePathToDir to (POSIX path of aliasPathToDir) as text
	end tell
	set theIconPath to ("" & thePathToDir & "PlatypusAppIcon.icns") as text
	set aliasIconPath to POSIX file theIconPath as alias
	
	set responseText to text returned of (display dialog "ベース・ファイル名を決めてくださいnこのままOKすると元のファイル名にn画像サイズを追加します" default answer theNewFileBseName with title "ファイル名を決めてください" giving up after 10 with icon aliasIconPath)
	
	return responseText
end run