# Enables the mongodb server using docker
docker pull mongo
wait
docker run -d -p 27017:27017 --name=mongodb mongo -v "./db/data"
wait
docker stop mongodb
wait

# Installs pm2 package globally
npm install pm2 -g
wait

# Sets up packages in nodejs servers
cd ../../authsrc
npm install
wait
cd ../src
npm install
wait 
cd ../


# Creates a run shell script after setup
cd ../../scripts/linux
touch run.sh
echo -e "docker start mongodb
\nwait
\ncd ../../
\npm2 start ecosystem.config.json
\nwait
\npm2 list" > run.sh
chmod +x ./run.sh

# Creates a stop shell script after setup
touch stop.sh
echo -e "docker stop mongodb
\nwait
\ncd ../../
\npm2 stop ecosystem.config.json
\nwait
\npm2 delete ecosystem.config.json" > stop.sh
chmod +x ./stop.sh