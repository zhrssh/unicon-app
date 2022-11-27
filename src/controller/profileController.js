const Profile = require("../model/resources/Profiles")
const getDate = require("../utils/logs").getDate

/**
 * Creates a new profile and store in the database
 * @param {*} req 
 * @param {*} res 
 */
async function createProfile(req, res) {
    // Create a new profile
    await Profile.create({
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        birthDate: req.body.birthDate,
        contactNumber: req.body.contactNumber,
        email: req.body.email
    })

    console.log(getDate(Date.now()), `Adding ${req.body.firstName} to the database...`)
}