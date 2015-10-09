'use strict'
Swift = require('../lib/swift')

module.exports = (grunt) ->
  grunt.registerMultiTask('swift', 'do swift upload', () ->
    done = @async()
    if not @target
      throw new Error('Task require a target. IE: swift:dev, swift:prod')
    taskOpts = grunt.config(['swift', 'options']) || {}
    targetOpts = grunt.config(['swift', @target, 'options']) || {}
    options = grunt.util._.merge({}, taskOpts, targetOpts)

    if not options.credentials
      throw new Error('Config options.credentials is required in Gruntfile')
    new Swift(options.credentials, grunt.log.writeln, (swift) ->
      swift.uploadFiles(options.path, done)
    )
  )
