require("dotenv").config()

const nodemailer = require("nodemailer")
const handlebars = require("handlebars")
const fs = require("fs")
const path = require("path")

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
 * Sends an email to the specified receipient. Path to HTML file is required.
 * @param {String} from 
 * @param {String} to 
 * @param {String} subj 
 * @param {*} dir 
 * @param {*} replc 
 */
function send(from, to, subj, dir, replc = null) {

    // Checks if there is path to html
    if (dir == null) {
        const error = new Error("Path to HTML is required.")
        error.code = "500"
        throw error
    }

    try {
        fs.readFile(path.join(__dirname, dir), { encoding: "utf-8" }, (err, html) => {
            if (err) {
                const error = new Error("Error reading file.")
                error.code = "500"
                throw error
            }

            // Prepares the template
            let template = handlebars.compile(html)
            let htmlToSend = template(replc)

            // Sends email to the new user
            try {
                _transport().sendMail(
                    {
                        from: from,
                        to: to,
                        subject: subj,
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
}

// Exports
module.exports.send = send