const Worker = require("../model/Workers")

/**
 * Creates a new worker profile
 * @param {*} userId 
 * @param {*} workerInfo 
 * @returns 
 */
function createWorkerProfile(userId, workerInfo) {
    return new Promise((resolve, reject) => {
        Worker.create({
            profileId: userId,
            profession: workerInfo.profession,
            about: workerInfo.about
        })
            .catch((err) => {
                const error = new Error("Error creating worker profile.")
                error.code = "500"
                reject(error)
            })
            .then(resolve(null))
    })
}

// Exports
module.exports.createWorkerProfile = createWorkerProfile