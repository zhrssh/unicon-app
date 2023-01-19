// Route for app.js
const express = require('express')
const router = express.Router()
const projectController = require("../controller/projectController")

// Gets all projects
router.get('/', async (req, res) => {
    try {
        const jobs = await projectController.getProjects()
        if (jobs === null) return res.sendStatus(404)
        return res.status(200).send(jobs)
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(400)
    }
})

// Gets all projects of a user
router.get("/userid=:userId", async (req, res) => {
    try {
        const projects = await projectController.getUserProjects(req.params.userId)
        if (projects === null) return res.sendStatus(404)
        return res.status(200).send(projects)
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(500)
    }
})

// Gets specific project of a user
router.get("/userid=:userId/projectid=:projectId", async (req, res) => {
    try {
        const project = await projectController.getUserProject(req.params.userId, req.params.projectId)
        if (project === null) return res.sendStatus(404)
        return res.status(200).send(project)
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(400)
    }
})

// Creates a new project
router.post("/create", async (req, res) => {
    try {
        await projectController.createProject(req.body.uuid, req.body.info)
        return res.sendStatus(200)
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
        return res.sendStatus(400)
    }
})

module.exports = router