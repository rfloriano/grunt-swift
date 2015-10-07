# grunt-swift 

[![Build Status][travis-image]][travis-url] [![npm][npm-image]][npm-url] 

[travis-image]: https://travis-ci.org/rflorianobr/grunt-swift.svg?branch=master
[travis-url]: https://travis-ci.org/rflorianobr/grunt-swift
[npm-image]: https://img.shields.io/npm/v/grunt-swift.svg?style=flat
[npm-url]: https://npmjs.org/package/grunt-swift
[coveralls-image]: https://coveralls.io/repos/rflorianobr/grunt-swift/badge.svg
[coveralls-url]: https://coveralls.io/r/rflorianobr/grunt-swift

[![js-standard-style](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/feross/standard)

Module for globo.com swift

## Install

```sh
$ npm install --save grunt-swift
```

## Usage

```
  # Gruntfile
  
  grunt.initConfig
    swift:
      options:
        credentials:
          auth:
            tenantName: 'my-tenant'
            passwordCredentials:
              username: 'my-user'
              password: 'my-pass'
          container: 'my-container'
          storageName: 'my-storage-name'
          storageURLAttribute: 'my-storage-url-attribute'
          storagePath: 'my-storage-path'
        path: '<%= config.dist %>/**/*.*'  # my pattern
      dev:
        options:
          credentials:
            host: 'https://my-auth-host-for-dev.com'
      prod:
        options:
          credentials:
            host: 'https://my-auth-host-for-prod.com'
```


## License

2015 MIT © [Rafael Floriano da Silva]()
