// Route for app.js
const express = require('express')
const router = express.Router()
const projectController = require("../controller/projectController")

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

router.get('/', (req, res) => {
    // Show all available Jobs
    try {
        projectController.getJobsFeed(req, res)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.get("/:uuid", (req, res) => {
    // Show user Jobs
    try {
        projectController.getUserJobsFeed(req, res)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.get("/workers/:id", (req, res) => {
    // Show current workers
    try {
        projectController.showCurrentWorkers(req, res)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.post("/", (req, res) => {
    // Posting a Job
    try {
        projectController.createJob(req, res)
        res.sendStatus(200)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.post("/:id", (req, res) => {
    // Applying to a job
    try {
        projectController.applyJob(req, res)
        res.sendStatus(200)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.delete("/:id", (req, res) => {
    // Delete a Job
    try {
        projectController.deleteJob(req, res)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

router.delete("/workers/:id", (req, res) => {
    // Delete a worker
    try {
        projectController.deleteWorker(req, res)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

module.exports = router