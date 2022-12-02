const jwt = require("jsonwebtoken")
const crypto = require("crypto")

const args = process.argv.slice(2)

/**
 * Generates a random crypto key
 * @param {*} data 
 * @param {Number} bytes 
 */
function generatekey(bytes=64) {
    const secret = crypto.randomBytes(parseInt(bytes)).toString('hex')
    console.log("secret: ", secret)
    return secret
}

generatekey(args[0])

module.exports = generatekey