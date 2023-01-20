const Profile = require("../model/Profiles")
const Project = require("../model/Projects")
const raise = require("../utils/raise")

/**
 * Create a new project for a user
 * @param {*} userId
 * @param {*} info
 * @returns Promise
 */
function createProject(userId, info) {
    return new Promise(async (resolve, reject) => {
        const user = await Profile.findOne({ uuid: userId })
        if (user === null) return reject(raise("User does not exists", 404))

        // Creates the project info then add the project id to the user
        Project.create(info)
            .catch(err => reject(raise(err.message, 400)))
            .then(value => {
                user.projects.push(value._id)
                user.save()
                    .catch(err => reject(raise(err.message, 400)))
                    .then(value => resolve(null))
            })
    })
}

/**
 * Delete a project.
 * @param {String} userId
 * @param {String} projectId
 * @returns
 */
function deleteProject(userId, projectId) {
    return new Promise(async (resolve, reject) => {
        await Profile.updateOne({ uuid: userId }, { $pull: { projects: projectId } })
            .catch(err => reject(raise(err.message, 400)))
            .then(result => resolve(null))
    })
}

/**
 * Get all available jobs
 * @returns projects | null 
 */
function getProjects() {
    return new Promise(async (resolve, reject) => {
        await Project.find({ visibility: "Public", status: "Active" })
            .catch(err => reject(raise(err.message, 400)))
            .then(projects => {
                if (projects === null) return resolve(null)
                return resolve(projects)
            })
    })
}

/**
 * Gets all user's project
 * @param {String} userId
 * @returns projects | null
 */
function getAllUserProjects(userId) {
    return new Promise(async (resolve, reject) => {
        await Profile.findOne({ uuid: userId })
            .catch(err => reject(raise(err.message, 400)))
            .then(result => {
                if (result === null) return reject(raise("User does not exists.", 404))
                if (result.projects.length <= 0) return resolve(null)
                return resolve(result.projects)
            })
    })
}

/**
 * Gets a specific project of a user
 * @param {String} userId 
 * @param {String} projectId 
 * @returns project | null 
 */
function getUserProject(userId, projectId) {
    return new Promise(async (resolve, reject) => {
        await Profile.findOne({ uuid: userId })
            .catch(err => reject(raise(err.message, 400)))
            .then(async user => {
                if (user === null) return reject(raise("User does not exists.", 404))
                const project = await user.get({ projects: projectId })
                return resolve(project)
            })
    })
}

//Exports
module.exports.createProject = createProject
module.exports.deleteProject = deleteProject
module.exports.getProjects = getProjects
module.exports.getUserProject = getUserProject
module.exports.getAllUserProjects = getAllUserProjects