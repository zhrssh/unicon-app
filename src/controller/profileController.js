const Profile = require("../model/Profiles")

/**
 * Creates a new profile and store in the database
 * @param {*} profile
 * @returns Promise
 */
function createProfile(profile) {
    return new Promise((resolve, reject) => {
        Profile.create(profile)
            .catch(err => reject(err))
            .then(result => resolve(null))
    })
}

/**
 * Creates or updates user profile from the database
 * @param {*} profile
 * @returns Promise
 */
function createOrUpdateProfile(profile) {
    return new Promise(async (resolve, reject) => {
        // Checks if the user already exists
        const user = await Profile.findOne({ uuid: profile.uuid })

        if (user == null) {

            // Creates a new profile if the user does not exists
            createProfile(profile)
            return resolve(null)
        }

        // Updates an existing profile
        user = profile
        user.save()
            .catch(err => reject(err))
            .then(result => resolve(null))
    })
}

/**
 * Updates a single key in the database
 * @param {String} uuid 
 * @param {String} key 
 * @param {*} value 
 * @returns Promise
 */
function updateProfileSingleKey(uuid, key, value) {
    return new Promise((resolve, reject) => {
        Profile.findOneAndUpdate({ uuid: uuid }, {
            $set: {
                [key]: value
            }
        })
            .catch(err => reject(err))
            .then(result => resolve(null))
    })
}

/**
 * Returns the user profile of the uuid
 * @param {*} uuid
 * @returns An object containing user profile
 */
function getUserProfile(uuid) {
    return new Promise(async (resolve, reject) => {
        const user = await Profile.findOne({ uuid: uuid })

        if (user === null) {
            const error = new Error("User does not exists.")
            error.code = "404"
            return reject(error)
        }

        return resolve(user)
    })
}

// Exports
module.exports.createOrUpdateProfile = createOrUpdateProfile
module.exports.getUserProfile = getUserProfile
module.exports.updateProfileSingleKey = updateProfileSingleKey