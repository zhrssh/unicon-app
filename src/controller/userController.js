const User = require("../model/Users")
const Profile = require("../model/Profiles")
const bcrypt = require("bcrypt")
const getDate = require("../log-func").getDate

// Creates a new user
async function createUser(req, res) {

    // Check if the user already exist
    const user = await User.findOne({ email: req.body.email }, "email")

    if (user != null) {
        throw new Error("Email already exists.")
    }

    // Validate password
    const validate = function (v) {
        let regex = /^[a-zA-Z0-9!@#\$%\^\&*\)\(+=._-]{12,}$/g
        return regex.test(v)
    }

    if (validate(req.body.password) === false) {
        throw new Error("Password requirements are not met.")
    }

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

    console.log(getDate(Date.now()), `Adding ${req.body.firstName} to the database...`)
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