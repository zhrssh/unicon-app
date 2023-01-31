require("dotenv").config()

const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")

const tokenController = require("../controller/tokenController")
const { getDate } = require("../utils/logs")
const getUserByEmail = require("../controller/userController").getUserByEmail
const raise = require("../utils/raise")

/**
 * Generates an expiring access token
 * @param {*} data 
 * @returns Access Token
 */
function generateAccessToken(data) {
    return jwt.sign({ data }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "24h" })
}

/**
 * Generates a refresh token
 * @param {*} data 
 * @returns Refresh Token
 */
function generateRefreshToken(data) {
    return jwt.sign({ data }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: "7d" })
}

/**
 * Requests access token using refresh token
 * @param {string} refreshToken
 * @returns {Promise<string>}
 */
function requestAccessToken(refreshToken) {
    return new Promise(async (resolve, reject) => {
        const refreshToken = refreshToken

        // Checks...
        if (refreshToken == null) return reject(raise("E01", 401))

        if (await checkRefreshTokenInDb(refreshToken) == false)
            return reject(raise("E02", 403))

        // Provide access token when the user is authenticated
        jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, result) => {
            if (err) return reject(raise("E02", 403))

            const accessToken = generateAccessToken(result.data)
            return resolve({ accessToken: accessToken })
        })
    })
}

/**
 * Generates a new refresh token
 * For logging in the app, only pass in the request the email, password, (old)refreshToken
 * For registering in the app, pass all the user information to generate a new refreshToken
 * @param {Object} userInfo  
 * @returns {Promise<{refreshToken : string, accessToken : string}>}
 */
function requestRefreshToken(userInfo) {
    return new Promise(async (resolve, reject) => {

        // Authenticate user
        let uuid
        const email = userInfo.email
        const password = userInfo.password

        let user, chk
        try {
            // Gets the user from the database
            user = await getUserByEmail(email)
            if (user == null) return reject(raise("E03", 404))

            // Checks email and password
            chk = user && user.email === email && await bcrypt.compare(password, user.password)
            if (chk === false) return reject(raise("E01", 401))

            // Checks if the user is verified
            chk = user && user.status === "Active"
            if (chk === false) return reject(raise("E02", 403))

            uuid = user._id

        } catch (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }

        // JWT Payload
        const data = {
            iss: process.env.ISS,
            uuid: uuid,
            status: user.status,
            role: user.role
        }

        // Generates the tokens
        const refreshToken = generateRefreshToken(data)
        const accessToken = generateAccessToken(data)

        // Stores or updates the refresh token in database
        await tokenController.storeToken(uuid, refreshToken)
            .then(resolve({
                refreshToken: refreshToken,
                accessToken: accessToken
            }))
            .catch(reject(raise("S01", 500)))
    })
}

/**
 * Checks the database for a saved refresh token
 * @param {str} refreshToken
 * @returns {Promise<boolean>}
 */
function checkRefreshTokenInDb(refreshToken) {
    return new Promise(async (resolve, reject) => {
        const tokenInDb = await tokenController.getToken(refreshToken)
            .catch(err => {
                if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
                return reject(raise(err.message, 500))
            })

        // Checks if the refresh token exists in database
        if (tokenInDb == null) return resolve(false)
        return resolve(true)
    })
}

/**
 * Verifies access token, can be used in other routes as middleware
 * @param {*} req 
 * @param {*} res 
 * @param {*} next 
 * @returns {Callback}
 */
function verifyAccessToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]

    // Returns error if user does not have token
    if (token == null) return res.status(401).send({ err: "E01" })

    try {
        // Verifies if token is valid
        jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, result) => {
            if (err) throw err
            req.body.uuid = result.data.uuid
            return next()
        })
    } catch (err) {
        if (process.env.NODE_ENV === "development") console.log(getDate(Date.now(), err.message))
        return res.status(403).send({ err: "E02" })
    }
}

/**
 * Deletes a refresh token from the database
 * @param {str} token 
 * @returns {Promise<null>}
 */
function deleteRefreshToken(token) {
    return new Promise((resolve, reject) => {
        try {
            tokenController.deleteToken(token)
            return resolve(null)
        } catch (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }
    })
}

/**
 * Gets the UUID from token without verifying the token. Use this if you know that the token is already verified
 * @param {*} req 
 * @returns {Promise<str>}
 */
function getUUIDFromToken(headers) {
    return new Promise((resolve, reject) => {
        // Gets Token from Auth Header
        const authHeader = headers['authorization']
        const token = authHeader && authHeader.split(' ')[1]

        if (token == null) return resolve(null)

        try {
            const decoded = jwt.decode(token)
            return resolve(decoded.data.uuid)
        } catch (err) {
            if (process.env.NODE_ENV === "development") console.log(getDate(Date.now()), err.message)
            return reject(raise("S01", 500))
        }
    })
}

// Exports
module.exports.verifyAccessToken = verifyAccessToken
module.exports.requestAccessToken = requestAccessToken
module.exports.deleteRefreshToken = deleteRefreshToken
module.exports.requestRefreshToken = requestRefreshToken
module.exports.getUUIDFromToken = getUUIDFromToken
module.exports.generateAccessToken = generateAccessToken