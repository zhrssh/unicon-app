const bcrypt = require("bcrypt")
const LocalStrategy = require("passport-local").Strategy

/**
 * Initializes the passport
 * @param {PassportStatic} passport 
 * @param {function} getUserByEmail 
 * @param {function} getUserById 
 */
function initializePassport(passport, getUserByEmail, getUserById) {
    
    // Function for authenticating user
    const authenticateUser = async (email, password, done) => {
        
        // Get user from the database
        const user = await getUserByEmail(email)

        // If the user does not exist in the database
        if (user == null) {
            return done(null, false, { message : `${email} does not exists.`}) // done(err, user, msg)
        }

        try {
            // Checking if the password is correct
            if (await bcrypt.compare(password, user.password)) {
                return done(null, user)
            } else {
                return done(null, false, { message : "Incorrect password." })
            }
        } catch (err) {
            return done(err)
        }

    }
    
    // Where authentication starts
    passport.use(new LocalStrategy({ usernameField: 'email'}), authenticateUser)
    passport.serializeUser((user, done) => { 
        done(null, user._id)
     })
    passport.deserializeUser(async (id, done) => { 
        done(null, await getUserById(id))
     })
}

// Exports
module.exports = initializePassport