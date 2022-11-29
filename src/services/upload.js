const multer = require("multer")
const path = require("path")
const fs = require("fs")

const auth = require("./auth")

// For uploading files

/**
 * Where images are stored
 */
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        const uuid = auth.getUUIDFromToken(req)
        const dir = `.\\uploads\\${file.fieldname}\\${uuid}`

        // Checks if there is a directory
        fs.stat(dir, (err, stats) => {
            // If a directory does not exist
            if (err && err.code == "ENOENT") {

                // Makes the directory and uploads the file
                fs.mkdir(dir, { recursive: true }, (err) => {
                    if (err) return cb(err.message)
                    cb(null, dir)
                })
            }

            // Clear the files first
            fs.readdir(dir, (err, files) => {
                if (err) return cb(err.message)

                for (const file of files) {
                    fs.unlink(path.join(dir, file), (err) => {
                        if (err) return cb(err.message)
                    })
                }
            })

            // Uploads the file to the directory
            cb(null, dir)
        })

    },
    filename: function (req, file, cb) {
        const uuid = auth.getUUIDFromToken(req)
        const fname = file.fieldname + "-" + uuid
        const extname = path.extname(file.originalname).toLocaleLowerCase()

        cb(null, fname + extname)
    }
})

/**
 * Filters the uploaded file
 * @param {*} req 
 * @param {*} file 
 * @param {function} cb 
 */
const fileFilter = (req, file, cb) => {
    // Allow only jpeg and png extensions
    const fileTypes = /jpeg|jpg|png/

    // Check extenstion file
    const extname = fileTypes.test(path.extname(file.originalname).toLowerCase())

    // Check mimetype
    const mimetype = fileTypes.test(file.mimetype)

    // Do check
    if (extname && mimetype)
        cb(null, true)
    else
        cb(new Error("Extension not allowed."), false)
}

/**
 * Multer object that contains the function single(), array(), fields, etc...
 */
const upload = multer({
    fileFilter: (req, file, cb) => fileFilter(req, file, cb),
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5 // 5 MB limit
    }
})

// Exports
module.exports = upload