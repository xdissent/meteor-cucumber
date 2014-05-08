
chokidar = Npm.require 'chokidar'

debug = (name, args...) ->
  console.log "Cucumber #{name} Watcher -", args... if Cucumber.settings.debug


class Cucumber.Watcher

  constructor: (@watch_path) ->

  watch: ->
    return if @_watcher?
    @_watcher = chokidar.watch @watch_path, @_options()
    @_watcher.on 'all', @_callback()

  unwatch: ->
    return unless @_watcher?
    @_watcher.close()
    @_watcher = null

  _options: -> {}

  _callback: ->

  _isFeature: (file) -> /\.feature$/.test file

  _isCode: (file) -> /\.(js|coffee)$/.test file

  _debug: -> debug @name, arguments...
