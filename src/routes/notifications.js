// Route for app.js
const express = require('express')
const router = express.Router()

// Middleware
router.use((req, res, next) => {
    // Some code to log requests in the console
    return next()
})

router.get('/', (req, res) => {
    // Starting point of the /notifications route
    res.sendStatus(200)
})

router.get("/test", (req, res) => {
    res.sendStatus(302)
})


// time received of notification
router.get('/notif', (req, res) => {
    const currentTime = new Date();
    res.send(`{currentTime}`);
    })
      
router.listen(3000, () => {
    console.log('Server started on port 3000');
      })


module.exports = router