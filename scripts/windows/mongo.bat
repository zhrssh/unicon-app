@REM Enables the mongodb server using docker
docker pull mongo
docker run -d -p 27017:27017 --name=mongodb mongo -v "./db/data"
docker stop mongodb