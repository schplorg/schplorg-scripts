#!/bin/bash
#path or device
isMounted () { findmnt -rno SOURCE,TARGET "$1" >/dev/null;}
#device only
isDevMounted () { findmnt -rno SOURCE "$1" >/dev/null;}
#path   only
isPathMounted () { findmnt -rno TARGET "$1" >/dev/null;}

mountAs () {
	if [ ! -d "/mnt/$2" ]; then
		mkdir "/mnt/$2"
	fi
	if isPathMounted "/mnt/$2";
	   then
		echo "$2 is mounted"
	   else
		echo "$2 is not mounted"
		echo "mounting $2"
#		sudo mount -U "$1" -o umask=0000,gid=65534,uid=65534 "/mnt/$2" && echo "mounted $2"
		sudo mount -U "$1" "/mnt/$2" && echo "mounted $2"
	fi
}

#mountAs 2e6e4f58-28b2-4ee4-b243-67761a46a458 one
#mountAs 9979b62d-c775-4db7-81d0-55a033b2ada5 two
#mountAs 4b7a66e2-aae5-4671-a785-2e52415addc2 one
#mountAs 5f52c7f6-f427-4209-bd9f-55a7709628f0 two
#mountAs 0f607d69-ad6f-4f16-9e0f-5fcf168f3f0b three
#mountAs 0c0d9bcd-360d-4de4-a425-335cd573d4f9 four
