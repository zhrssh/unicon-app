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
        Profile.findOneAndUpdate({ uuid: req.body.uuid }, {
            firstName: req.body.firstName,
            lastName: req.body.lastName,
            birthDate: new Date(req.body.birthDate),
            contactNumber: req.body.contactNumber
        })
    }

    console.log(getDate(Date.now()), `Updating user: ${req.body.firstName}...`)
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
        const data = {
            firstName: profile.firstName,
            lastName: profile.lastName,
            birthDate: profile.birthDate,
            contactNumber: profile.contactNumber
        }

        return data
    } catch {
        const error = new Error("Error finding user profle.")
        error.code = "500"
        throw error
    }
}

// Exports
module.exports.createOrUpdateProfile = createOrUpdateProfile
module.exports.getUserProfile = getUserProfile