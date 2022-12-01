// Getting Date and Time
function getDate(millis) {
    return (new Date(ms = millis)).toISOString()
}

// Exports
module.exports.getDate = getDate