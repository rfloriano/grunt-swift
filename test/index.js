'use strict'

var gruntSwift = require('../')
var test = require('tape')

test('awesome:test', function (t) {
  t.ok(gruntSwift() === 'awesome')
  t.end()
})
