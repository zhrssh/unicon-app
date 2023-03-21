const Provider = require("../model/Providers")
const getDate = require("../utils/logs").getDate
const raise = require("../utils/raise")

/**
 * Creates a new worker profile
 * @param {Object} providerInfo 
 * @returns {Promise<null>}
 */
function createProvider(providerInfo) {
    return new Promise(async (resolve, reject) => {
        await Provider.create(providerInfo)
            .then(resolve(null))
            .catch((err) => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

/**
 * Updates user provider profile from the database
 * @param {Object} providerInfo
 * @returns {Promise<null>}
 */
function updateProvider(uuid, providerInfo) {
    return new Promise(async (resolve, reject) => {
        // Checks if the user already exists
        const user = await Provider.findOne({ uuid: uuid })

        if (user == null)
            return reject(raise("E03", 404))

        // Updates an existing profile
        user.update({ $set: providerInfo })
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
function getProvider(uuid) {
    return new Promise(async (resolve, reject) => {
        const user = await Provider.findOne({ uuid: uuid })
        if (user === null) return reject(raise("E03", 404))
        return resolve(user)
    })
}

// Exports
module.exports.createProvider = createProvider
module.exports.updateProvider = updateProvider
module.exports.getProvider = getProvider