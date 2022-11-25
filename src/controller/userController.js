const User = require("../model/Users")
const Profile = require("../model/Profiles")
const bcrypt = require("bcrypt")

// Creates a new user
async function createUser(req, res) {

    // Encrypt password
    const salt = await bcrypt.genSalt()
    const hashedPassword = await bcrypt.hash(req.body.password, salt)
    
    // Create the user
    let userId
    await User.create({
        email: req.body.email,
        password: hashedPassword,
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

    console.log(`Adding ${req.body.firstName} to the database...`)
}

async function getUser(email) {
    try {
        const user = await User.findOne({ email: email })
        return user
    } catch (err) {
        return null
    }
}

// Exports
module.exports.createUser = createUser
module.exports.getUser = getUser