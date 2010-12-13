#!/bin/zsh
if [ `timestamp 2>/dev/null` ]; then
	filename="/home/metalelf0/Dropbox/codice elf0/FinanzeRails-$(timestamp).zip"
else
	filename="/home/metalelf0/Dropbox/codice elf0/FinanzeRails-latest.zip"
fi
if [ -e "$filename" ]; then
	echo "Removing previous version from Dropbox..."
	mv "$filename" /tmp/
fi
echo "Archiving current version in dropbox..."
git archive -o "$filename" HEAD
echo "Done!"

