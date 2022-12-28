require("dotenv").config()

const fs = require("fs")
const handlebars = require("handlebars")
const nodemailer = require("nodemailer")
const path = require("path")

const User = require("../model/Users")
const generateKey = require("../utils/generate").generateKey

/**
 * Sets the user to "Active", indicating the email is verified.
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
}

/**
 * Sends an email verification to the user
 * @param {*} req 
 * @param {*} res 
 */
function _transport() {
    return nodemailer.createTransport(
        {
            service: "Gmail",
            secure: true,
            auth: {
                user: process.env.EMAIL,
                pass: process.env.PASS
            }
        })
}

/**
 * Sends confirmation email to the newly created user
 * @param {*} req 
 * @param {*} res 
 */
async function sendConfirmationEmail(req, res) {
    // Read html file
    let htmlToSend

    try {
        fs.readFile(path.join(__dirname, "/../templates/verify.html"), { encoding: "utf-8" }, (err, html) => {
            if (err) {
                const error = new Error("Error reading file.")
                error.code = "500"
                throw error
            }

            // Prepares the template
            let template = handlebars.compile(html)

            let replacements = {
                email: req.body.email,
                confirmationCode: req.body.confirmationCode,
                confirmationLink: `http://localhost:3001/register/verify/${req.body.uuid}/${req.body.confirmationCode}`,
                emailSupport: "support@uniconapp.com"
            }

            htmlToSend = template(replacements)

            // Sends email to the new user
            try {
                _transport().sendMail(
                    {
                        from: process.env.EMAIL,
                        to: req.body.email,
                        subject: "RE: Account Verification",
                        html: htmlToSend
                    })
            } catch (err) {
                const error = new Error(err.message)
                error.code = "500"
                throw error
            }
        })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

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