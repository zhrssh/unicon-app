const User = require('../model/Users')

// Creates a new user
const createUser = async (req, res) => {
    try {
        User.create({
            email: "test",
            password: "test",
            hasAcceptedTerms: true,
            profileId: "id1235123"
        })
    } catch (err) {
        console.log(`Error: ${err}`)
    }
}

// Exports
module.exports.createUser = createUser