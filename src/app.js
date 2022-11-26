require("dotenv").config()

const express = require("express") // Express
const helmet = require("helmet") // For added http security
const app = express() // Express App
const db = require("./db/database") // Database.js
const getDate = require("./log-func").getDate
const auth = require("./auth-config")

// Routes
const credentials = require("./routes/credentials")
const feed = require("./routes/feed")
const jobs = require("./routes/jobs")
const login = require("./routes/login")
const notifications = require("./routes/notifications")
const profile = require("./routes/profile")
const register = require("./routes/register")
const logout = require("./routes/logout")

// Default PORT
const PORT = process.env.PORT || 3000

// App middlewares
app.use(helmet()) // For improved http security (src: https://www.npmjs.com/package/helmet)
app.use(express.json()) // Use JSON
app.use((req, res, next) => { // Displays all requests
    console.log(getDate(Date.now()), `New Request: ${req.method} @ ${req.url}`)
    next()
})

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
app.use("/api/login", login) // Login
app.use("/api/notifications", auth.verifyAccessToken, notifications)
app.use("/api/profile", auth.verifyAccessToken, profile)
app.use("/api/register", register)
app.use("/api/logout", auth.verifyAccessToken, logout)

// When accessing non-existing routes
app.all('*', (req, res, next) => {
    res.sendStatus(404)
})