// Main app of the server
const express = require("express")
const helmet = require('helmet')
const app = express()

// Routes
const credentials = require("./routes/credentials")
const feed = require("./routes/feed")
const jobs = require("./routes/jobs")
const login = require("./routes/login")
const notifications = require("./routes/notifications")
const profile = require("./routes/profile")
const register = require("./routes/register")

// Default PORT
const PORT = process.env.PORT || 3000

// Default Use
app.use(helmet()) // For improved http security (src: https://www.npmjs.com/package/helmet)
app.use(express.json()) // Use JSON

// Starting point of the server
app.get('/', (req, res) => {
    // If connected, proceed to login
    res.status(200).send({ 'body': 'Hello, there!' })

    // If not connected, send error status
})

// Routes
app.use("/credentials", credentials)
app.use("/feed", feed)
app.use("/jobs", jobs)
app.use("/login", login) // Login
app.use("/notifications", notifications)
app.use("/profile", profile)
app.use("/register", register)

// When accessing non-existing routes
app.all('*', (req, res, next) => {
    res.status(404).send({ "body": "Error 404: Page Not Found...", })
})

// Listen to port
app.listen(PORT, () => { console.log(`Listening to port ${PORT}...`) })