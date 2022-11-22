const User = require("../model/Users")
const Profile = require("../model/Profiles")

// Creates a new user
const createUser = async (req, res) => {

    // Create the user
    let userId
    await User.create({
        email: req.body.email,
        password: req.body.password,
        hasAcceptedTerms: req.body.hasAcceptedTerms
    })
        .then(user => {
            userId = user._id
        })

    // Create a new profile
    await Profile.create({
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        birthDate: req.body.birthDate,
        contactNumber: req.body.contactNumber,
        userId: userId
    })
}

// Exports
module.exports.createUser = createUser