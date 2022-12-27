require("dotenv").config()

const nodemailer = require("nodemailer")
const User = require("../model/Users")

/**
 * Sets the user to "Active", indicating the email is verified.
 * @param {*} confirmationCode 
 */
async function verifyUser(confirmationCode) {
    const user = await User.findOne({ confirmationCode: confirmationCode }, "confirmationCode")

    // Checks if the user with the confirmation code exists
    if (user == null) {
        const error = new Error("Confirmation code does not exist.")
        error.code = "404"
        throw error
    }

    // Sets the user status to "Active"
    try {
        user.set({
            status: "Active"
        })
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
    return nodemailer.createTransport("SMTP",
        {
            service: "Gmail",
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
function sendConfirmationEmail(req, res) {
    try {
        _transport().sendMail(
            {
                from: process.env.EMAIL,
                to: req.body.email,
                subject: "RE: Account Verification",
                html: `<h1>Email Confirmation</h1>
            <h2>Hello There!</h2>
            <p>Thank you for registering. Please confirm your email by clicking on the following link</p>
            <a href=http://localhost:${process.env.PORT}/register/verify/${req.body.confirmationCode}> Click here</a>
            </div>`
            })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

    res.sendStatus(200)
}

// Exports
module.exports.sendConfirmationEmail = sendConfirmationEmail
module.exports.verifyUser = verifyUser