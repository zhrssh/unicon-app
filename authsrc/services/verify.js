require("dotenv").config()

const path = require("path")

const User = require("../model/Users")
const generateKey = require("../utils/generate").generateKey
const send = require("./email").send

/**
 * Sets the user to "Active", indicating the email is verified. 
 * Sends another email telling the user is verified.
 * @param {*} confirmationCode 
 */
async function verifyUser(uuid, confirmationCode) {
    const user = await User.findOne({ _id: uuid })

    // Checks if the user with the confirmation code exists
    if (user == null) {
        const error = new Error("User does not exist.")
        error.code = "404"
        throw error
    }

    // Checks if the correct code is sent
    if (user.confirmationCode !== confirmationCode) {
        const error = new Error("Incorrect confirmation code.")
        error.code = "401"
        throw error
    }

    // Sets the user status to "Active"
    try {
        user.status = "Active"
        await user.save()
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

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

    // Sends the email
    send(config.from, config.to, config.subject, dir, replacements)
}

/**
 * Sends confirmation email to the newly created user
 * @param {*} req 
 * @param {*} res 
 */
function sendConfirmationEmail(req, res) {

    // Path to html
    let dir = "/../templates/verify.html"

    // Email config
    let config = {
        from: process.env.EMAIL,
        to: req.body.email,
        subject: "RE: Account Verification"
    }

    // Replacements to the html file
    let replacements = {
        email: req.body.email,
        confirmationCode: req.body.confirmationCode,
        confirmationLink: `http://localhost:3001/register/verify/${req.body.uuid}/${req.body.confirmationCode}`,
        emailSupport: "support@uniconapp.com"
    }

    // Send email
    send(config.from, config.to, config.subject, dir, replacements)

    res.status(200).send({ uuid: req.body.uuid })
}

/**
 * Generates a new code and resends it to user
 * @param {*} req 
 * @param {*} res 
 */
async function resendConfirmationEmail(req, res) {
    const user = await User.findOne({ _id: req.body.uuid })

    // Check for user
    if (user == null) {
        const error = new Error("User does not exist.")
        error.code = "404"
        throw error
    }

    // Generates a new code
    const newCode = generateKey(3).toLowerCase()

    user.confirmationCode = newCode
    await user.save((err, result) => {
        if (err) {
            const error = new Error("Error saving to database.")
            error.code = "500"
            throw error
        }
    })

    req.body.email = user.email
    req.body.confirmationCode = newCode
    sendConfirmationEmail(req, res)
        .catch(err => {
            if (err) {
                const error = new Error(err.message)
                error.code = "500"
                throw error
            }
        })
}

// Exports
module.exports.sendConfirmationEmail = sendConfirmationEmail
module.exports.verifyUser = verifyUser
module.exports.resendConfirmationEmail = resendConfirmationEmail