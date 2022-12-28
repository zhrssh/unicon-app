require("dotenv").config()

const nodemailer = require("nodemailer")
const User = require("../model/Users")

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
            <p>Thank you for registering. Here is your code to activate your account: <b>${req.body.confirmationCode}</b></p>
            <p>OR <a href=http://localhost:${process.env.PORT}/register/verify/${req.body.uuid}/${req.body.confirmationCode}> Click here</a></p>
            </div>`
            })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "500"
        throw error
    }

    res.status(200).send({ uuid: req.body.uuid })
}

// Exports
module.exports.sendConfirmationEmail = sendConfirmationEmail
module.exports.verifyUser = verifyUser