require("dotenv").config()

const bcrypt = require("bcrypt")
const { default: mongoose } = require("mongoose")

const User = require("../model/Users")
const getDate = require("../utils/logs").getDate
const generateKey = require("../utils/generate").generateKey
const raise = require("../utils/raise")

/**
 * Creates a new user and store it in the database.
 * @param {*} userInfo
 * @returns {Promise<{ uuid : string, code : string }>}
 */
function createUser(userInfo) {
    return new Promise(async (resolve, reject) => {
        // Check if the user already exist
        const user = await User.findOne({ email: userInfo.email }, "email")
        if (user != null) return reject(raise("E05", 409))

        // Validate password
        const validate = function (v) {
            let regex = /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]{12,}$/g
            return regex.test(v)
        }

        if (validate(userInfo.password) === false) return reject(raise("E05", 409))

        // Encrypt password
        const salt = await bcrypt.genSalt()
        const hashedPassword = await bcrypt.hash(userInfo.password, salt)

        // Create confirmation code
        const code = generateKey(3).toLowerCase()

        // Create the user
        let _userId
        await User.create({
            email: userInfo.email,
            password: hashedPassword,
            confirmationCode: code
        }).then((user) => {
            _userId = user._id

            if (process.env.NODE_ENV === "development")
                console.log(getDate(Date.now()), `Adding ${userInfo.email} to the database...`)

            return resolve({ uuid: _userId, code: code })
        }).catch((err) => reject(raise("S01", 500)))


    })
}

/**
 * Finds a user from the database using email
 * @param {string} email 
 * @returns {Promise<mongoose.Document<User>>}
 */
function getUserByEmail(email) {
    return new Promise(async (resolve, reject) => {
        try {
            const user = await User.findOne({ email: email })
            if (user == null) return resolve(null)
            return resolve(user)
        } catch (err) {
            if (process.env.NODE_ENV === "development")
                console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }
    })
}

/**
 * Finds a user from the database using uuid
 * @param {string} uuid
 * @returns {Promise<mongoose.Document<User>>}
 */
function getUserByUUID(uuid) {
    return new Promise(async (resolve, reject) => {
        try {
            const user = await User.findById(uuid)
            if (user == null) return resolve(null)
            return resolve(user)
        } catch (err) {
            if (process.env.NODE_ENV === "development")
                console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }
    })
}

/**
 * Deletes a user from the database using uuid
 * @param {string} uuid 
 * @returns {Promise<null>}
 */
function deleteUser(uuid) {
    return new Promise((resolve, reject) => {
        try {
            User.deleteOne({ id: uuid })
            return resolve(null)
        } catch (err) {
            if (process.env.NODE_ENV === "development")
                console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }
    })
}

// Exports
module.exports.createUser = createUser
module.exports.getUserByEmail = getUserByEmail
module.exports.getUserByUUID = getUserByUUID
module.exports.deleteUser = deleteUser