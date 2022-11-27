require("dotenv").config()

const Token = require("../model/auth/Tokens")
const getDate = require("../utils/logs").getDate

/**
 * Stores the token in the token database
 * @param {String} uuid
 * @param {String} myToken 
 */
async function storeToken(uuid, myToken) {
    try {
        const token = await Token.findOneAndUpdate({ uuid: uuid }, { refreshToken: myToken })

        if (token == null) throw null

        console.log(getDate(Date.now()), "Updating refresh token to the database.")
    } catch (err) {
        await Token.create({
            uuid: uuid,
            refreshToken: myToken
        })

        console.log(getDate(Date.now()), "Adding refresh token to the database.")
    }
}

/**
 * Finds the token from the database
 * @param {String} myToken 
 * @returns Token
 */
async function getToken(myToken) {
    try {
        const token = await Token.findOne({ refreshToken: myToken })
        return token
    } catch (err) {
        return null
    }
}

/**
 * Delets token from the database
 * @param {String} myToken 
 */
async function deleteToken(myToken) {
    await Token.findOneAndUpdate({ refreshToken: myToken }, { refreshToken: null })
    console.log(getDate(Date.now()), "Deleting refresh token from the database.")
}

// Exports
module.exports.storeToken = storeToken
module.exports.getToken = getToken
module.exports.deleteToken = deleteToken