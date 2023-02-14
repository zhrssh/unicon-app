require("dotenv").config()

const express = require("express") // Express
const helmet = require("helmet") // For added http security
const morgan = require("morgan") // For logging
const app = express() // Express App
const db = require("./db/database") // Database.js
const getDate = require("./utils/logs").getDate
const auth = require("./services/auth")

// Routes
const feed = require("./routes/feed")
const projects = require("./routes/project")
const notifications = require("./routes/notifications")
const client = require("./routes/client")
const provider = require("./routes/provider")

// Default PORT
const PORT = process.env.RSC_PORT || 3001

// App middlewares
app.use(morgan("dev"))
app.use(helmet()) // For improved http security (src: https://www.npmjs.com/package/helmet)
app.use(express.json()) // Use JSON

// Connect to the database
const DATABASE_URL = process.env.RSCDB_URL || "mongodb://127.0.0.1:27017/unicondb"
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
app.get('/api/', auth.verifyAccessToken, (req, res) => {
    // If connected, proceed to login
    res.status(200).send({ 'body': 'Hello, there!' })
})

// Routes
app.use("/api/feed", auth.verifyAccessToken, feed)
app.use("/api/projects", auth.verifyAccessToken, projects)
app.use("/api/notifications", auth.verifyAccessToken, notifications)
app.use("/api/client", auth.verifyAccessToken, client)
app.use("/api/provider", auth.verifyAccessToken, provider)

// When accessing non-existing routes
app.all('*', (req, res) => {
    res.sendStatus(404)
})