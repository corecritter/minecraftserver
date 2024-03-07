sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install default-jre -y
sudo apt-get install default-jdk -y
sudo mkdir /minecraft
#need to agree to the eula
echo 'eula=true' | sudo tee /minecraft/eula.txt
#this url might change with newer versions?
sudo curl https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar --output /minecraft/server.jar
cd /minecraft
#1024 = Amount of RAM to allow the java process to use, can be changed to desired Amount
# this runs in a screen  and can be detached with Ctrl-a + d. The screen -S "mc" can be removed to run server directly
sudo screen -S "mc" java -Xmx1024M -Xms1024M -jar server.jar nogui
#re-attach
# sudo -u root screen -x "mc"
#quit screen
# sudo -u root screen -XS "mc" quit