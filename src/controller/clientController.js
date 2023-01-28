const Client = require("../model/Clients")
const getDate = require("../utils/logs")
const raise = require("../utils/raise")

/**
 * Creates a new profile and store in the database
 * @param {Object} clientInfo
 * @returns {Promise<null>}
 */
function createClient(clientInfo) {
    return new Promise((resolve, reject) => {
        Client.create(clientInfo)
            .then(resolve(null))
            .catch(err => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

/**
 * Updates user profile from the database
 * @param {Object} clientInfo
 * @returns {Promise<null>}
 */
function updateClient(uuid, clientInfo) {
    return new Promise(async (resolve, reject) => {
        // Checks if the user already exists
        const user = await Client.findOne({ uuid: uuid })

        if (user == null)
            return reject(raise("E03", 404))

        // Updates an existing profile
        user.update({ $set: clientInfo })
        user.save()
            .then(resolve(null))
            .catch(err => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

/**
 * Returns the user profile of the uuid
 * @param {string} uuid
 * @returns {Promise<mongoose.Document<Client>>}
 */
function getClient(uuid) {
    return new Promise(async (resolve, reject) => {
        const user = await Client.findOne({ uuid: uuid })
        if (user === null) return reject(raise("E03", 404))
        return resolve(user)
    })
}

// Exports
module.exports.createClient = createClient
module.exports.updateClient = updateClient
module.exports.getClient = getClient