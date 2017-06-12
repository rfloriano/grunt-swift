async = require('async')
glob = require('glob')
storage = require('openstack-storage')
path = require('path')
fs = require('fs')

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0' # Temos certificados não assinados no Swift dos ambientes :/


class SwiftUpload
  constructor: (@options, logger, cb) ->
    @logger = logger || console.log
    authFn = async.apply(storage.authenticate, @options)
    @service = new storage.OpenStackStorage(authFn, (err, res, tokens) =>
      if err
        @logger('[Swift Auth] ', err, ', tokens: ', tokens)
      else
        @tokens = tokens
        @logger('[Swift Auth] ' + res.statusCode + ' - ' + tokens.id)
        cb(@)
    )

  uploadFiles: (paths, cb) ->
    paths = [paths] if not Array.isArray(paths)
    for p in paths
      counter = 0
      @uploadFile(p, () ->
          counter += 1
      )
    setInterval(() =>
      cb() if counter == paths.length
    , 200)

  uploadFile: (file, cb) ->
    remoteName = path.join(@options.storagePath, file)

    putFileOptions =
      remoteName: remoteName
      localFile: file

    @service.putFile(@options.container, putFileOptions, (err, statusCode) =>
      url = @tokens.storageUrl + path.join('/', @options.container, remoteName)
      @logger('[Swift upload] ' + statusCode + ' - ' + url)
      if err
        @logger(err)
      cb()
    )

module.exports = SwiftUpload
