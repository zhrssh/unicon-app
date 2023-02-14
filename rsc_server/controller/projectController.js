const Client = require("../model/Clients")
const Project = require("../model/Projects")
const raise = require("../utils/raise")

/**
 * Create a new project for a user
 * @param {string} uuid
 * @param {Object} info
 * @returns {Promise<null>}
 */
function createProject(uuid, info) {
    return new Promise(async (resolve, reject) => {
        const client = await Client.findOne({ uuid: uuid })
        if (client === null) return reject(raise("User does not exists", 404))

        // Creates the project info then add the project id to the user
        Project.create(info)
            .catch(err => reject(raise(err.message, 400)))
            .then(value => {
                client.projects.push(value._id)
                client.save()
                    .catch(err => reject(raise(err.message, 400)))
                    .then(value => resolve(null))
            })
    })
}

/**
 * Delete a project.
 * @param {string} uuid
 * @param {string} projectId
 * @returns {Promise<null>}
 */
function deleteProject(uuid, projectId) {
    return new Promise(async (resolve, reject) => {
        await Client.updateOne({ uuid: uuid }, { $pull: { projects: projectId } })
            .catch(err => reject(raise(err.message, 400)))
            .then(result => resolve(null))
    })
}

/**
 * Get all available jobs
 * @returns {Promise<mongoose.Document<Project> | null>} 
 */
function getProjects() {
    return new Promise(async (resolve, reject) => {
        await Project.find({ visibility: "Public", status: "Active" })
            .then(projects => {
                if (projects === null) return resolve(null)
                return resolve(projects)
            })
            .catch(err => reject(raise(err.message, 400)))
    })
}

/**
 * Gets all user's project
 * @param {string} uuid
 * @returns {Promise<mongoose.Document<Project> | null>}
 */
function getAllClientProjects(uuid) {
    return new Promise(async (resolve, reject) => {
        await Client.findOne({ uuid: uuid }).populate("projects")
            .then(result => {
                if (result === null) return reject(raise("E03", 404))
                if (result.projects.length <= 0) return resolve(null)
                return resolve(result.projects)
            })
            .catch(err => reject(raise(err.message, 400)))
    })
}

/**
 * Gets a specific project of a user
 * @param {String} uuid 
 * @param {String} projectId 
 * @returns {Promise<mongoose.Document<Project | null>}
 */
function getClientProject(uuid, projectId) {
    return new Promise(async (resolve, reject) => {
        await Client.findOne({ uuid: uuid })
            .catch(err => reject(raise(err.message, 400)))
            .then(async user => {
                if (user === null) return reject(raise("E03", 404))
                const project = await user.get({ projects: projectId })
                return resolve(project)
            })
    })
}

//Exports
module.exports.createProject = createProject
module.exports.deleteProject = deleteProject
module.exports.getProjects = getProjects
module.exports.getUserProject = getClientProject
module.exports.getAllUserProjects = getAllClientProjects