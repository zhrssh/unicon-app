const Worker = require("../model/Workers")
const getDate = require("../utils/logs").getDate
const raise = require("../utils/raise")

/**
 * Creates a new worker profile
 * @param {Object} providerInfo 
 * @returns {Promise<null>}
 */
function createProviderProfile(providerInfo) {
    return new Promise((resolve, reject) => {
        Worker.create(providerInfo)
            .then(resolve(null))
            .catch((err) => {
                if (process.env.NODE_ENV === "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
    })
}

// Exports
module.exports.createProviderrProfile = createProviderProfile