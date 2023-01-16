const Worker = require("../model/Workers")

// TODO: CRUD regarding worker profiles

function createWorkerProfile(req, res) {
    Worker.create({
        profileId: req.body.uuid,
        profession: req.body.profession,
        about: req.body.about
    })
}