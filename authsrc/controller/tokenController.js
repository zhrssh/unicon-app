require("dotenv").config()

const Token = require("../model/Tokens")
const getDate = require("../utils/logs").getDate
const raise = require("../utils/raise")

/**
 * Stores the token in the token database
 * @param {string} uuid
 * @param {string} myToken
 * @returns {Promise<null>}
 */
function storeToken(uuid, myToken) {
    return new Promise(async (resolve, reject) => {
        // Find and update
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), "Updating refresh token to the database.")
        const token = await Token.findOneAndUpdate({ uuid: uuid }, { refreshToken: myToken })

        // Create new token
        if (token == null) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), "Adding refresh token to the database.")

            await Token.create({
                uuid: uuid,
                refreshToken: myToken
            })
                .catch(err => reject(raise(err.message, 500)))
                .then(result => resolve(null))
        }

        return resolve(null)
    })
}

/**
 * Finds the token from the database
 * @param {string} myToken 
 * @returns {Promise<mongoose.Document<Token>>}
 */
function getToken(myToken) {
    return new Promise(async (resolve, reject) => {
        try {
            const token = await Token.findOne({ refreshToken: myToken })
            return resolve(token)
        } catch (err) {
            return reject(raise(err.message, 500))
        }
    })
}

/**
 * Delets token from the database
 * @param {string} myToken 
 * @returns {Promise<null>}
 */
function deleteToken(myToken) {
    return new Promise((resolve, reject) => {
        if (process.env.NODE_ENV === "development ") console.log(getDate(Date.now()), "Deleting refresh token from the database.")
        Token.findOneAndUpdate({ refreshToken: myToken }, { $set: { refreshToken: null } })
            .catch(err => reject(raise(err.message, 500)))
            .then(result => resolve(null))
    })
}

// Exports
module.exports.storeToken = storeToken
module.exports.getToken = getToken
module.exports.deleteToken = deleteToken