const Profile = require("../model/Profiles")
const Project = require("../model/Projects.Js")
const getDate = require("../utils/logs").getDate


/**
 * Add a Job
 * @param {*} req 
 * @param {*} res 
 */
 async function createJob(req, res) {
    const user = await Profile.findOne({uuid:req.body.uuid})
    const name = `${user.firstName} ${user.lastName}`
    await Project.create({
        uuid : user.uuid,
        postedBy: name,
        description: req.body.description,
        estSalary: req.body.estSalary,
        estDate: req.body.estDate,
        location: req.body.location
        })

    console.log(getDate(Date.now()), `Adding a Job to the database...`)
}

/**
 * Delete a Job
 * @param {*} req 
 * @param {*} res 
 */
 async function deleteJob(req, res) {
    const user = await Profile.findOne({uuid:req.body.uuid})
    const post = await Project.findById(req.params.id);
    if(post.uuid === user.uuid){
        await post.delete();
        res.sendStatus(200)
    }else{
        res.status(403).send("You can only delete your own post")
    }
}


/**
 * Show all available Jobs
 * @param {*} req 
 * @param {*} res 
 */
async function getJobsFeed(req, res) {
    const feed = await Project.find();
    res.json(feed)
}

/**
 * Show user jobs
 * @param {*} req 
 * @param {*} res 
 */
 async function getUserJobsFeed(req, res) {
    const feed = await Project.find({uuid:req.params.uuid})
    if (feed.length != 0){
        res.json(feed)
    }else{
        res.status(403).send("No Jobs available")
    }
}


/**
 * Show current wokers
 * @param {*} req 
 * @param {*} res 
 */
 async function showCurrentWorkers(req, res) {
    const post = await Project.findById(req.params.id)
    const currentWorkers = post.currentWorkers
    if (currentWorkers.length != 0){
        res.json(currentWorkers)
    }else{
        res.status(403).send("No workers applied")
    }
}

/**
 * Remove a worker
 * @param {*} req 
 * @param {*} res 
 */
async function deleteWorker(req, res) {
    await Project.findByIdAndUpdate( 
        req.params.id, { 
            $pull: { "currentWorkers" : {_id:req.body.id }}
        },
    )//not yet working
}


/**
 * Adding contractor to a job
 * @param {*} req 
 * @param {*} res 
 */
 async function addContractor(req, res) {

}



//Exports
module.exports.createJob = createJob
module.exports.deleteJob = deleteJob
module.exports.getJobsFeed = getJobsFeed
module.exports.getUserJobsFeed = getUserJobsFeed
module.exports.showCurrentWorkers = showCurrentWorkers
module.exports.deleteWorker = deleteWorker
module.exports.addContractor = addContractor //not yet implemented