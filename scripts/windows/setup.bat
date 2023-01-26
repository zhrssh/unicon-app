@REM Enables the mongodb server using docker
call mongo.bat

@REM Installs pm2 package globally
call npm install pm2 -g

@REM # Sets up packages in nodejs servers
cd ../../authsrc
call npm install
cd ../src
call npm install 
cd ../

@REM Creates a run shell script after setup
cd ../../scripts/linux
(
echo "call docker start mongodb"
echo "cd ../../"
echo "call pm2 start ecosystem.config.json"
echo "pm2 list"
) > run.bat

@REM Creates a stop shell script after setup
(
echo "call docker stop mongodb"
echo "cd ../../"
echo "call pm2 stop ecosystem.config.json"
echo "call pm2 delete ecosystem.config.json"
echo "pm2 list"
) > stop.bat