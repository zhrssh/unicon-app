require("dotenv").config()

const nodemailer = require("nodemailer")
const handlebars = require("handlebars")
const fs = require("fs")
const path = require("path")

const getDate = require("../utils/logs").getDate

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
 * @returns {Promise<null>}
 */
function send(from, to, subj, dir, replc = null) {
    return new Promise((resolve, reject) => {
        // Checks if there is path to html
        if (dir == null) {
            if (process.env.NODE_ENV == "development")
                console.log(getDate(Date.now()), "Requires path to the html.")
            return reject("Requires path to the html.")
        }

        fs.readFile(path.join(__dirname, dir), { encoding: "utf-8" }, (err, html) => {
            if (err) {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(err.message)
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

                resolve(null)
            } catch (err) {
                if (process.env.NODE_ENV == "development")
                    console.log(getDate(Date.now()), err.message)
                return reject(err.message)
            }
        })
    })
}

// Exports
module.exports.send = send