sudo apt-get update
sudo apt-get install openjdk-7-jre
mkdir --parents $HOME/minecraft
cd $HOME/minecraft
wget https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar
echo "jfriedly" > ops.txt
java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
