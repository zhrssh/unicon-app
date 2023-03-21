# UNICON
## Description:
- An application designed to help our local contractors in the construction industry.
## How to Run:
1. **Run MongoDB Server**
    - Start a local or remote MongoDB server.
    - Copy the uri+db to the dot-env file of each app directory. (e.g. `mongodb://localhost:27017/mydb`)
    - ***NOTE: Make sure dot-env file has the following variables:***
        - DATABASE_URL
        - PORT
        - ISS
        - ACCESS_TOKEN_SECRET
        - REFRESH_TOKEN_SECRET
        - EMAIL (for auth_server)
        - PASS (for auth_server)
2. **Run Authentication Server (unicon-app/auth_server)**
    - Run app.js using `node`
    - Run app.js using `pm2`
    - Run app.js using `dockerfile`
3. **Run Resources Server (unicon-app/rsc_server)**
    - Run app.js using `node`
    - Run app.js using `pm2`
    - Run app.js using `dockerfile`
4. **Build the app (unicon-app/unicon)**
    - Build the app with the following .env variables
        - Authentication server url
        - Resource server url
    - Build the app using:
        - ```flutter build apk --debug``` if there is no keystore is present.
        - ```flutter build appbundle``` if uploading to Play Store
5. **Download the apk file of the unicon application and run.**