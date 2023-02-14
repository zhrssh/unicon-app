/**
 * Creates and error with error code.
 * @param {String} message 
 * @param {Number} code 
 * @returns {Object} Error
 */
function raise(message, code) {
    const error = new Error(message)
    error.code = code
    return error
}

// Exports
module.exports = raise