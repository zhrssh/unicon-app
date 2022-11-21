// Importing mocha and chai
const mocha = require('mocha')
const chai = require('chai')

const expect = chai.expect

// ~~~~~~~~~~~ test.js ~~~~~~~~~~~
const samplefunc = (x, y) => {
    var sum = x + y
    return sum
}

// module.exports = samplefunc
// ~~~~~~~ end of test.js ~~~~~~~~

// Importing js files, in this example we embed
// const samplefunct = require('test.js')

describe('samplefunc', () => {
    it('expect sum to be 10', () => {
        var sum = samplefunc(7, 3)
        expect(sum).to.equal(10)
    })

    it('expect sum to be 20', () => {
        var sum = samplefunc(10, 10)
        expect(sum).to.equal(20)
    })

    it('expect sum to be 7', () => {
        var sum = samplefunc(3, 3)
        expect(sum).to.equal(7)
    })
})

