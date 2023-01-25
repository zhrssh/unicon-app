# Enables the mongodb server using docker
docker pull mongo
wait
docker run -d -p 27017:27017 --name=mongodb mongo -v "./db/data"
wait
docker stop mongodb

# Sets up packages in nodejs servers
cd ../../authsrc
npm install
wait
cd ../src
npm install
wait 
cd ../


# Creates a run shell script after setup
cd ./scripts/linux
touch run.sh
echo -e "docker start mongodb
\n wait
\ncd ./../../authsrc
\nnohup npm run dev > auth.log &
\ncd ./../src
\nnohup npm run dev > rsc.log &" > run.sh
wait
chmod +x ./run.sh

# Creates a stop shell script after setup
touch stop.sh
echo -e "pkill -f 'nohup npm run dev'
\ndocker stop mongodb
\nlsof -t -i:3000 | xargs kill -9
\nwait
\nlsof -t -i:3001 | xargs kill -9" > stop.sh
chmod +x ./stop.sh