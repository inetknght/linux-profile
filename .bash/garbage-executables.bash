#!/usr/bin/bash

# List of garbage apps
#
# Disabling these is perfectly "safe". Some apps might hate you. Those apps are
# garbage and you shouldn't use them.
garbage=(
	# Gnome Virtual Filesystem
	# I absolutely DO NOT want Gnome to run daemons for garbage.
	#
	# That includes shit like:
	# afc: iPhone / iPod Touch
	# afp: Apple Filing Protocol
	# dav: insecure HTTP WebDAV
	# dnssd: DNS Service Discovery
	# ftp: insecure FTP
	# fuse: I use FUSE manually. Fuck your management of my shit.
	# goa: Gnome Online Accounts
	# gphoto2: GNU Photo
	# http: insecure HTTP
	# metadata: GVFS metadata handler. Fuck your shit, for real.
	# mtp: Media Transfer Protocol
	# smb: Windows Samba
	# nfs: insecure NFS
	# sftp: piss off I'll do it myself
	#
	# Extra shitty shit like such:
	# computer: computer://
	# network: network://
	# recent: recent://
	# trash: trash://
	# 
	/usr/lib/gvfs/gvfs-{afc,afp,afp-browse,dav,dnssd,ftp,fuse,goa,gphoto2,http,metadata,mtp,smb,smb-browse,nfs,sftp,computer,network,recent,trash}-volume-monitor
	/usr/lib/gvfs/gvfsd-{afc,afp,afp-browse,dav,dnssd,ftp,fuse,goa,gphoto2,http,metadata,mtp,smb,smb-browse,nfs,sftp,computer,network,recent,trash}

	# Any sort of credential-caching "agent" whatsoever is an insecure anti-pattern.
	# -> ssh-agent
	# -> seahorse
	# -> gnome-keyring
	/usr/bin/ssh-agent
	/usr/bin/seahorse
	/usr/bin/gnome-keyring{,-3,-daemon}

	# Autostarting bluetooth garbage
	/usr/lib/bluetooth/bluetoothd
	/usr/lib/blueman/blueman-mechanism
)

# Filter list on whether garbage is executable
garbage=( "$(
	for g in "${garbage[@]}"
	do
		if [ -x "${g}" ]
		then
			echo -n "${g} "
		fi
	done
)" )

# If any are, then tell me.
if [ "${#garbage}" -gt 0 ]
then
	>&2 echo "~/.bashrc: garbage is executable: ${garbage[@]}"
	exit 1
fi
