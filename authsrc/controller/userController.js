const bcrypt = require("bcrypt")
const { verify } = require("jsonwebtoken")

const User = require("../model/Users")
const getDate = require("../utils/logs").getDate
const generateKey = require("../utils/generate").generateKey

/**
 * Creates a new user and store it in the database
 * @param {*} req 
 * @param {*} res 
 * @returns UUID & Confirmation Code
 */
async function createUser(req, res) {

    // Check if the user already exist
    const user = await User.findOne({ email: req.body.email }, "email")

    if (user != null) {
        const error = new Error("Email already exists.")
        error.code = "409"
        throw error
    }

    // Validate password
    const validate = function (v) {
        let regex = /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]{12,}$/g
        return regex.test(v)
    }

    if (validate(req.body.password) === false) {
        const error = new Error("Password does not met requirements.")
        error.code = "403"
        throw error
    }

    // Encrypt password
    const salt = await bcrypt.genSalt()
    const hashedPassword = await bcrypt.hash(req.body.password, salt)

    // Create confirmation code
    const code = generateKey(64)

    // Create the user
    let _userId
    await User.create({
        email: req.body.email,
        password: hashedPassword,
        confirmationCode: code
    }).then((user) => {
        _userId = user._id
    }).catch((err) => {
        const error = new Error("Internal server error.")
        error.code = "500"
        throw error
    })

    console.log(getDate(Date.now()), `Adding ${req.body.email} to the database...`)
    return _userId, code
}

/**
 * Finds a user from the database using email
 * @param {String} email 
 * @returns 
 */
async function getUserByEmail(email) {
    try {
        const user = await User.findOne({ email: email })
        return user
    } catch (err) {
        return null
    }
}

/**
 * Finds a user from the database using uuid
 * @param {String} uuid
 * @returns User
 */
async function getUserByUUID(uuid) {
    try {
        const user = await User.findById(uuid)
        return user
    } catch (err) {
        return null
    }
}

async function deleteUser(uuid) {
    try {
        await User.deleteOne({ id: uuid })
    } catch (err) {
        const error = new Error(err.message)
        error.code = "400"
        throw error
    }
}

// Exports
module.exports.createUser = createUser
module.exports.getUserByEmail = getUserByEmail
module.exports.getUserByUUID = getUserByUUID
module.exports.deleteUser = deleteUser