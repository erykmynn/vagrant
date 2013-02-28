# Install local site in hosts file and run virtual machine.
HAS_SUDO=`command -v sudo 2>/dev/null`

# Locate hosts file.
if [ -f "/etc/hosts" ]; then
  FILE_HOSTS="/etc/hosts"
fi
if [ -f "/cygdrive/c/windows/system32/drivers/etc/hosts" ]; then
  FILE_HOSTS="/cygdrive/c/windows/system32/drivers/etc/hosts"
fi
if [ -z "$FILE_HOSTS" ]; then
  echo "Can not find hosts file."
  exit 1
fi
echo "Hosts file found at: $FILE_HOSTS"

# Check if hosts file has our site.local in it.
HOST_ENTRY=`cat $FILE_HOSTS | grep site.local`
if [ -z "$HOST_ENTRY" ]; then
  echo "Adding site.local to hosts file."
  if [ ! -z "$HAS_SUDO" ]; then
    sudo -- sh -c "echo '33.33.33.66 site.local' >> $FILE_HOSTS"
  else
    sh -c "echo '33.33.33.66 site.local' >> $FILE_HOSTS"
  fi
else
  echo "Host entry already found: $HOST_ENTRY"
fi

# Build VM.
vagrant destroy --force
vagrant up

