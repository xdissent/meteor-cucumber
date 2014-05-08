
cucumber = Npm.require 'cucumber'
disrequire = Npm.require 'disrequire'


# Runs tests locally
class Cucumber.Runner.Local extends Cucumber.Runner

  constructor: (@mirror) ->
    super()
    @_reloads = []
    @_configuration = cucumber.Cli.Configuration @_args()

  _args: ->
    args = [null, null]
    if Cucumber.settings.format?
      args = args.concat '--format', Cucumber.settings.format
    args = args.concat '--coffee' if Cucumber.settings.coffee
    args = args.concat '--tags', tag for tag in Cucumber.settings.tags
    args.concat [Cucumber.settings.path]

  _startMirror: (callback) ->
    if @mirror? then @mirror.start callback else callback null

  _formatter: (callback) ->
    fmt = new cucumber.Listener.JsonFormatter
    fmt.log = (results) -> callback null, JSON.parse results
    fmt

  _runtime: (callback) ->
    runtime = cucumber.Runtime @_configuration
    runtime.attachListener @_formatter callback
    if Cucumber.settings.format?
      runtime.attachListener @_configuration.getFormatter()
    runtime

  _run: (callback) =>
    @_reload()
    @_startMirror (err) =>
      return callback err if err?
      features = null
      success = null
      called = false

      _callback = (err, _features, _success) ->
        return if called
        features ?= _features
        success ?= _success
        return unless features? and success? or err?
        called = true
        return callback err if err?
        result = if success then 'passed' else 'failed'
        callback null, result: result, features: features

      @_runtime(_callback).start (success) -> _callback null, null, success

  reload: (file) -> @_reloads.push file

  _reload: ->
    [reloads, @_reloads] = [@_reloads, []]
    disrequire file for file in reloads
