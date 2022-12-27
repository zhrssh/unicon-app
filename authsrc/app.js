require("dotenv").config()

const express = require("express") // Main app
const morgan = require("morgan") // For logging
const helmet = require("helmet")

const getDate = require("./utils/logs").getDate // For logging
const db = require("./db/database") // For database

// Server configs
const server = express()
const PORT = process.env.PORT || 3001

// Connect to the database
const DATABASE_URL = process.env.DATABASE_URL || "mongodb://127.0.0.1:27017/uniconauth"
const DB_OPTIONS = {
    useNewUrlParser: true,
    useUnifiedTopology: true
}

db.connectDb(DATABASE_URL, DB_OPTIONS)
    .then((result) => {

        // Listen to port
        server.listen(PORT, console.log(getDate(Date.now()), `Auth. server listening to port ${PORT}...`))

    })
    .catch((reason) => {
        console.log(getDate(Date.now(), `Failed to connect to db: ${reason}`))
    })

// Routes
const login = require("./routes/login")
const logout = require("./routes/logout")
const register = require("./routes/register")

// Middlewares
server.use(morgan("dev"))
server.use(helmet())
server.use(express.json())

// Routes
server.use("/login", login)
server.use("/logout", logout)
server.use("/register", register)

// Respond to non-existing routes
server.all("*", (req, res) => {
    res.sendStatus(404)
})