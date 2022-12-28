const auth = require("../services/auth")
const crypto = require("crypto")

/**
 * Generates a random crypto key
 * @param {*} data 
 * @param {Number} bytes 
 */
function generateKey(bytes = 64) {
    const secret = crypto.randomBytes(parseInt(bytes)).toString('hex')
    return secret
}

// Exports
module.exports.generateKey = generateKey