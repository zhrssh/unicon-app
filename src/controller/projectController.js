const Profile = require("../model/Profiles")
const Project = require("../model/Projects")

/**
 * Create a new project for a user
 * @param {*} req 
 * @param {*} res 
 */
function createProject(userId, info) {
    return new Promise(async (resolve, reject) => {
        const user = await Profile.findOne({ uuid: userId })

        if (user === null) {
            const error = new Error("User does not exists.")
            error.code = "404"
            reject(error)
        }

        Project.create({
            postedBy: user._id,
            description: info.description,
            estSalary: info.estSalary,
            estDate: info.estDate,
            location: {
                address: info.location.address,
                city: info.location.city,
                province: info.location.province
            }
        })
            .catch(err => reject(err))
            .then(value => resolve(null))
    })
}

/**
 * Delete a project.
 * @param {String} userId
 * @param {String} projectId
 */
function deleteProject(userId, projectId) {
    return new Promise(async (resolve, reject) => {
        const user = await Profile.findOne({ uuid: userId })
        if (user === null) {
            const error = new Error("User does not exists.")
            error.code = "404"
            reject(error)
        }

        Project.findOneAndDelete({ postedBy: user._id, _id: projectId })
            .catch(err => reject(err))
            .then(value => resolve(null))
    })
}

/**
 * Get all available jobs
 * @returns projects | null 
 */
function getProjects() {
    return new Promise(async (resolve, reject) => {
        const projects = await Project.find({ visibility: "Public", status: "Active" })
            .catch(err => reject(err))

        if (projects === null) return resolve(null)
        return resolve(projects)
    })
}

/**
 * Gets all user's project
 * @param {String} userId
 * @returns projects | null
 */
function getAllUserProjects(userId) {
    return new Promise(async (resolve, reject) => {
        const user = await Profile.findOne({ uuid: userId })
            .catch(err => reject(err))
        if (user === null) {
            const error = new Error("User does not exists.")
            error.code = "404"
            reject(error)
        }

        const projects = await Project.find({ postedBy: user._id })
            .catch(err => reject(err))

        if (projects === null) return resolve(null)
        return resolve(projects)
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
        const user = await Profile.findOne({ uuid: userId })
        if (user === null) {
            const error = new Error("User does not exists.")
            error.code = "404"
            reject(error)
        }

        const project = await Project.findOne({ postedBy: user._id, _id: projectId })
        if (project === null) return resolve(null)
        return resolve(project)
    })
}

//Exports
module.exports.createProject = createProject
module.exports.deleteProject = deleteProject
module.exports.getProjects = getProjects
module.exports.getUserProject = getUserProject
module.exports.getAllUserProjects = getAllUserProjects