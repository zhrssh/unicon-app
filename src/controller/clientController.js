const Client = require("../model/Clients")
const raise = require("../utils/raise")

/**
 * Creates a new profile and store in the database
 * @param {Object} clientInfo
 * @returns {Promise<null>}
 */
function createClient(clientInfo) {
    return new Promise((resolve, reject) => {
        Client.create(clientInfo)
            .then(result => resolve(null))
            .catch(err => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

/**
 * Creates or updates user profile from the database
 * @param {Object} clientInfo
 * @returns {Promise<null>}
 */
function createOrUpdateClient(clientInfo) {
    return new Promise(async (resolve, reject) => {
        // Checks if the user already exists
        const user = await Client.findOne({ uuid: clientInfo.uuid })

        if (user == null) {
            // Creates a new profile if the user does not exists
            await createClient(clientInfo)
                .then(result => resolve(null))
                .catch(err => {
                    if (process.env.NODE_ENV === "development")
                        console.log(getDate(Date.now()), err.message)
                    return reject(raise("S01", 500))
                })
        }

        // Updates an existing profile
        user.update({ $set: { profile: clientInfo } })
        user.save()
            .then(result => resolve(null))
            .catch(err => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

/**
 * Updates a single key in the database
 * @param {string} uuid 
 * @param {string} key 
 * @param {*} value 
 * @returns {Promise<null>}
 */
function updateClientSingleKey(uuid, key, value) {
    return new Promise((resolve, reject) => {
        Client.findOneAndUpdate({ uuid: uuid }, {
            $set: {
                [key]: value
            }
        })
            .then(result => resolve(null))
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
function getUserClient(uuid) {
    return new Promise(async (resolve, reject) => {
        const user = await Client.findOne({ uuid: uuid })
        if (user === null) return reject(raise("E03", 404))
        return resolve(user)
    })
}

// Exports
module.exports.createOrUpdateClient = createOrUpdateClient
module.exports.getUserClient = getUserClient
module.exports.updateClientSingleKey = updateClientSingleKey