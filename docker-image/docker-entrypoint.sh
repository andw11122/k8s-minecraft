#!/bin/bash
echo "Running entrypoint script."

# Get minecraft jarfile
echo "Downloading version $VERSION"
#wget -q https://launcher.mojang.com/v1/objects/b58b2ceb36e01bcd8dbf49c8fb66c55a9f0676cd/server.jar -P /home/minecraft/
wget -q https://cdn.getbukkit.org/spigot/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar -P /home/minecraft/

mv /home/minecraft/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar /home/minecraft/server.jar
echo "Accepting eula..."
echo "# Generated via Docker on $(date)" > /minecraft-data/eula.txt
echo "eula=$EULA" >> /minecraft-data/eula.txt
if [ $? != 0 ]; then
  echo "ERROR: unable to write eula to /data. Please make sure attached directory is writable by uid=${UID}"
  exit 2
fi

exec "$@"
