// communicates with database
/*
/**
 * Creates a new profile and store in the database
 * @param {*} message
 * @returns Name

function print(message) { return name}

print()
*/

/*
function or async function
await - halt on findOne if resolve or reject 
*/
/*
await add()

function add(x, y) {
    return new Promise((resolve, reject) => {
        //fromRemote = addchuchunes..
        resolve(value)
    })
}
*/

/**
 * Create a new project for a user
 * @param {*} userId
 * @param {*} type
 * @returns 
 */

function createNotification(userId, type){
        return new Promise(async (resolve, reject) => {
            const user = await Profile.findOne({ uuid: userId })
            if (user === null) return reject(raise("No User Found", 404))
    
            // Creates the project info then add the project id to the user
            Project.create(type)
                .catch(err => reject(raise(err.message, 400)))
                .then(value => {
                    user.projects.push(value._id)
                    user.save()
                        .catch(err => reject(raise(err.message, 400)))
                        .then(value => resolve(null))
                })
        })
    }

/**
 * Create a new project for a user
 * @param {*} userId
 * @param {*} 
 * @returns 
 */
function deleteNotification(userId, ) {
        return new Promise(async (resolve, reject) => {
            await Profile.updateOne({ uuid: userId }, { $pull: { projects: projectId } })
                .catch(err => reject(raise(err.message, 400)))
                .then(result => resolve(null))
        })
    } 
