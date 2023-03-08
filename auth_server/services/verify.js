require("dotenv").config()

const User = require("../model/Users")
const generateKey = require("../utils/generate").generateKey
const send = require("./email").send
const raise = require("../utils/raise")
const getDate = require("../utils/logs").getDate

/**
 * Sets the user to "Active", indicating the email is verified. 
 * Sends another email telling the user is verified.
 * @param {string} uuid
 * @param {string} confirmationCode 
 * @returns {Promise<null>}
 */
function verifyUser(uuid, confirmationCode) {
    return new Promise(async (resolve, reject) => {

        const user = await User.findOne({ _id: uuid })

        // Checks if the user with the confirmation code exists
        if (user == null) {
            if (process.env.NODE_ENV == "development")
                console.log(getDate(Date.now()), "User does not exists.")
            return reject(raise("E03", 404))
        }

        // Checks if the correct code is sent
        if (user.confirmationCode !== confirmationCode) {
            if (process.env.NODE_ENV == "development")
                console.log(getDate(Date.now()), "Incorrect confirmation code.")
            return reject(raise("E01", 401))

        }

        // Sets the user status to "Active"
        user.status = "Active"
        user.save((err, result) => {
            if (err) {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject("S01", 500)
            }
        })

        // Send success email to the user
        let dir = "/../templates/success.html"

        // Email config
        let config = {
            from: process.env.EMAIL,
            to: user.email,
            subject: "RE: Account Verification Successful"
        }

        // Replacements in the html
        let replacements = {
            email: user.email,
            emailSupport: "support@uniconapp.com"
        }

        // Send email
        if (process.env.NODE_ENV == "development")
            return resolve(null)

        send(config.from, config.to, config.subject, dir, replacements)
            .catch(err => {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })

        resolve(null)
    })
}

/**
 * Sends confirmation email to the newly created user
 * @param {Object} userInfo
 * @returns {Promise<null>}
 */
function sendConfirmationEmail(userInfo) {
    return new Promise(async (resolve, reject) => {
        // Path to html
        let dir = "/../templates/verify.html"

        // Email config
        let config = {
            from: process.env.EMAIL,
            to: userInfo.email,
            subject: "RE: Account Verification"
        }

        // Replacements to the html file
        let replacements = {
            email: userInfo.email,
            confirmationCode: userInfo.code,
            emailSupport: "support@uniconapp.com"
        }

        // Send email
        if (process.env.NODE_ENV == "development")
            return resolve(null)

        await send(config.from, config.to, config.subject, dir, replacements)
            .catch(err => {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            })
            .then(result => resolve(null))
    })
}

/**
 * Generates a new code and resends it to user. Accepts email only.
 * @param {Object} userInfo
 * @returns {Promise<null>}
 */
function resendConfirmationEmail(userInfo) {
    return new Promise(async (resolve, reject) => {
        const user = await User.findOne({ email: userInfo.email })

        // Check for user
        if (user == null) {
            if (process.env.NODE_ENV == "development")
                console.log(getDate(Date.now()), "User does not exists.")
            return reject(raise("E03", 404))
        }

        // Check if already verified
        if (user.status === "Active") {
            if (process.env.NODE_ENV == "development")
                console.log(getDate(Date.now()), "User is already verified.")
            return reject(raise("E05", 409))
        }

        // Generates a new code
        const newCode = generateKey(3)

        user.confirmationCode = newCode
        user.save((err, result) => {
            if (err) {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(raise("S01", 500))
            }
        })

        // Resends confirmation email
        userInfo.code = newCode
        if (process.env.NODE_ENV == "development")
            return resolve(null)

        sendConfirmationEmail(userInfo)
            .catch(err => {
                if (err) {
                    if (process.env.NODE_ENV == "development")
                        console.log(getDate(Date.now()), err.message)
                    return reject(raise("S01", 500))
                }
            })
            .then(result => resolve(null))
    })
}

// Exports
module.exports.sendConfirmationEmail = sendConfirmationEmail
module.exports.verifyUser = verifyUser
module.exports.resendConfirmationEmail = resendConfirmationEmail