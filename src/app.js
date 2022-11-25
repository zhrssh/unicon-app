const express = require("express") // Express
const helmet = require("helmet") // For added http security
const app = express() // Express App
const db = require("./db/database") // Database.js
const getDate = require("./log-func").getDate

// Routes
const credentials = require("./routes/credentials")
const feed = require("./routes/feed")
const jobs = require("./routes/jobs")
const login = require("./routes/login")
const notifications = require("./routes/notifications")
const profile = require("./routes/profile")
const register = require("./routes/register")

// Config file
if (process.env.NODE_ENV != "production") {
    require("dotenv").config()
}

// Default PORT
const PORT = process.env.PORT || 3000

// App middlewares
app.use(helmet()) // For improved http security (src: https://www.npmjs.com/package/helmet)
app.use(express.json()) // Use JSON
app.use((req, res, next) => { // Displays all requests
    console.log(getDate(Date.now()), `New Request: ${req.method}`)
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
app.use("/api/credentials", credentials)
app.use("/api/feed", feed)
app.use("/api/jobs", jobs)
app.use("/api/login", login) // Login
app.use("/api/notifications", notifications)
app.use("/api/profile", profile)
app.use("/api/register", register)

// When accessing non-existing routes
app.all('*', (req, res, next) => {
    res.status(404).send({ "body": "Error 404: Page Not Found...", })
})