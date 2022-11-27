require("dotenv").config()

const express = require("express") // Express
const helmet = require("helmet") // For added http security
const morgan = require("morgan") // For logging
const app = express() // Express App
const db = require("./db/database") // Database.js
const getDate = require("./utils/logs").getDate
const auth = require("./services/auth")

// Routes
const credentials = require("./routes/resources/credentials")
const feed = require("./routes/resources/feed")
const jobs = require("./routes/resources/jobs")
const notifications = require("./routes/resources/notifications")
const profile = require("./routes/resources/profile")

// Default PORT
const PORT = process.env.PORT || 3000

// App middlewares
app.use(morgan("dev"))
app.use(helmet()) // For improved http security (src: https://www.npmjs.com/package/helmet)
app.use(express.json()) // Use JSON

// Connect to the database
const DATABASE_URL = process.env.DATABASE_URL || "mongodb://127.0.0.1:27017/unicondb"
const DB_OPTIONS = {
    useNewUrlParser: true,
    useUnifiedTopology: true
}

db.connectDb(DATABASE_URL, DB_OPTIONS)
    .then((result) => {
        // Listen to port
        app.listen(PORT, () => {
            console.log(getDate(Date.now()), `Listening to port ${PORT}...`)
        })
    })
    .catch((reason) => {
        console.log(getDate(Date.now(), `Failed to connect to db: ${reason}`))
    })

// Starting point of the server
app.get('/', (req, res) => {
    // If connected, proceed to login
    res.status(200).send({ 'body': 'Hello, there!' })
})

// Routes
app.use("/api/credentials", auth.verifyAccessToken, credentials)
app.use("/api/feed", auth.verifyAccessToken, feed)
app.use("/api/jobs", auth.verifyAccessToken, jobs)
app.use("/api/notifications", auth.verifyAccessToken, notifications)
app.use("/api/profile", auth.verifyAccessToken, profile)

// When accessing non-existing routes
app.all('*', (req, res) => {
    res.sendStatus(404)
})