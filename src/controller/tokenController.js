require("dotenv").config()

const jwt = require("jsonwebtoken")
const Token = require("../model/Tokens")
const getDate = require("../log-func").getDate

/**
 * Stores the token in the token database
 * @param {String} token 
 */
async function storeToken(token) {
    await Token.create({
        refreshToken: token
    })

    console.log(getDate(Date.now()), "Adding refresh token to the database.")
}

/**
 * Finds the token from the database
 * @param {String} token 
 */
async function getToken(token) {
    try {
        const token = await Token.findOne({refreshToken: token})
        return token
    } catch (err) {
        return null
    }
}

async function deleteToken(token) {
    await Token.findOneAndDelete({refreshToken : token}, (err, obj) => {
        if (err) throw new Error(err.message)
        console.log(getDate(Date.now()), "Refresh token deleted.")
    })
}

// Exports
module.exports.storeToken = storeToken
module.exports.getToken = getToken
module.exports.deleteToken = deleteToken