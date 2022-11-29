const Profile = require("../model/resources/Profiles")
const getDate = require("../utils/logs").getDate

/**
 * Creates a new profile and store in the database
 * @param {*} req 
 * @param {*} res 
 */
function _createProfile(req, res) {
    // Create a new profile
    Profile.create({
        uuid: req.body.uuid,
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        birthDate: new Date(req.body.birthDate),
        contactNumber: req.body.contactNumber,
    })

    console.log(getDate(Date.now()), `Adding ${req.body.firstName} to the database...`)
}

/**
 * Creates or updates user profile from the database
 * @param {*} req 
 * @param {*} res 
 */
async function createOrUpdateProfile(req, res) {
    // Checks if the user already exists
    const profile = await Profile.findOne({ uuid: req.body.uuid })

    if (profile == null) {
        _createProfile(req, res)
    } else {
        await Profile.findOneAndUpdate({ uuid: req.body.uuid }, {
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            birthDate: new Date(req.body.birthDate),
            contactNumber: req.body.contactNumber
        })
    }

    console.log(getDate(Date.now()), `Updating user: ${req.body.firstName}...`)
}

/**
 * Updates a single key in the database
 * @param {String} uuid 
 * @param {String} key 
 * @param {*} value 
 */
async function updateSingle(uuid, key, value) {

    await Profile.findOneAndUpdate({ uuid: uuid }, {
        $set: {
            [key]: value
        }
    })

    console.log(getDate(Date.now()), `Updating ${key} of ${uuid}.`)
}

/**
 * Returns the user profile of the uuid
 * @param {*} req 
 * @param {*} res 
 * @returns An object containing user profile
 */
async function getUserProfile(req, res) {
    try {
        const profile = await Profile.findOne({ uuid: req.body.uuid })
        return profile
    } catch {
        const error = new Error("Error finding user profle.")
        error.code = "500"
        throw error
    }
}

// Exports
module.exports.createOrUpdateProfile = createOrUpdateProfile
module.exports.getUserProfile = getUserProfile
module.exports.updateSingle = updateSingle