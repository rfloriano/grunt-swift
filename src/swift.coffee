async = require('async')
glob = require('glob')
storage = require('openstack-storage')
path = require('path')

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0' # Temos certificados não assinados no Swift dos ambientes :/


class SwiftUpload
  constructor: (@options, logger, cb) ->
    @logger = logger || console.log
    authFn = async.apply(storage.authenticate, @options)
    @service = new storage.OpenStackStorage(authFn, (err, res, tokens) =>
      @tokens = tokens
      @logger('[Swift Auth] ' + res.statusCode + ' - ' + tokens.id)
      cb(@)
    )

  uploadFiles: (path, cb) ->
    glob(path, (err, files) =>
      counter = 0
      for file in files
        @uploadFile(file, () ->
          counter += 1
        )
      setInterval(() =>
        cb() if counter == files.length
      , 200)
    )

  uploadFile: (filename, cb) ->
    remoteName = filename

    if @options.storagePath?
      remoteName = path.join(@options.storagePath, filename.split('/').pop())

    putFileOptions =
      remoteName: remoteName
      localFile: filename

    @service.putFile(@options.container, putFileOptions, (err, statusCode) =>
      url = @tokens.storageUrl + path.join('/', @options.container, remoteName)
      @logger('[Swift upload] ' + statusCode + ' - ' + url)
      if err
        @logger(err)
      cb()
    )

module.exports = SwiftUpload
