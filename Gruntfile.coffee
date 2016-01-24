fs   = require 'fs'
path = require 'path'

module.exports = (grunt) ->
  grunt.initConfig
    service:
      ###
      reactor:
        shellCommand: "elm-reactor --port 8000"
        pidFile: '/tmp/elm-reactor.pid'
        generatePID: true
      ###

      backend:
        shellCommand: "stack runghc -- -isrc Main"
        pidFile: 'pids/backend.pid'
        options:
          stdio: 'inherit'

    elm:
      compile:
        files:
          'public/js/elm.js': 'client/Main.elm'

    jade:
      compile:
        files:
          "public/index.html": "client/jade/index.jade"
        options:
            data:
              development: true

    connect:
      server:
        options:
          port: 8000
          base: 'public'
          middleware: (connect, options, middlewares) ->
            middlewares.push (req, res, next) -> switch
              when /\/(js|css)\//.exec req.url
                res.writeHead 404, {'Content-Type': 'text/html'}
                res.end("Not found")
              else
                res.writeHead 200, {'Content-Type': 'text/html'}
                fs.createReadStream('public/index.html').pipe res
            return middlewares

    coffee:
      compile:
        cwd: "client/coffee"
        src: ["**/*.coffee"]
        dest: "public/js"
        ext: ".js"
        expand: true
        flatten: false
        bare: false

    stylus:
      options:
        compress: true
      compile:
        files: [
          cwd: "client/stylus/"
          src: ["[^_]*.styl"]
          dest: "public/css"
          ext: ".css"
          expand: true
        ]

    watch:
      coffee:
        files: ["client/coffee/**/*.coffee"]
        tasks: ["newer:coffee:compile"]

      stylus:
        files: ["client/stylus/**/*.styl"]
        tasks: ["stylus:compile"]

      elm:
        files: ["client/**/*.elm"]
        tasks: ["elm:compile"]

      jade:
        files: ["client/jade/*.jade"]
        tasks: ["jade:compile:newer"]

      hs:
        files: ["src/**/*.hs"]
        tasks: ["service:backend:restart"]

      css:
        files: ["public/css/**/*.css"]
        options:
          livereload:
            port: 35729

      html:
        files: ["public/**/*.html"]
        options:
          livereload:
            port: 35729

      js:
        files: ["public/js/**/*.js"]
        options:
          livereload:
            port: 35729

    copy:
      main:
        files: [
          {expand: true, src: ['assets/**'], dest: 'public/'}
        ]

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-newer"
  grunt.loadNpmTasks "grunt-elm"
  grunt.loadNpmTasks "grunt-service"

  grunt.registerTask "default", ["coffee", "stylus", "jade", "elm", "service:backend", "connect", "watch"]
