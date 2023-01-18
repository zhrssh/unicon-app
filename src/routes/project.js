// Route for app.js
const express = require('express')
const router = express.Router()
const projectController = require("../controller/projectController")

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    next()
})

// Gets all projects
router.get('/', async (req, res) => {
    try {
        const jobs = await projectController.getProjects()
        if (jobs === null) return res.sendStatus(404)
        return res.status(200).send(jobs)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        return res.sendStatus(500)
    }
})

// Gets all projects of a user
router.get("/userid=:userId", async (req, res) => {
    try {
        const projects = await projectController.getUserProjects(req.params.userId)
        if (projects === null) return res.sendStatus(404)
        return res.status(200).send(projects)
    } catch (err) {
        console.log(getDate(Date.now()), err.message)
        res.sendStatus(500)
    }
})

// Gets specific project of a user
router.get("/userid=:userId/projectid=:projectId", async (req, res) => {

})

// Gets all current workers of a project
router.get("/:userId/:projectId/workers", async (req, res) => {
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