
cucumber = Npm.require 'cucumber'
Module = Npm.require 'module'


# Runs tests locally
class Cucumber.Runner.Local extends Cucumber.Runner

  constructor: (@mirror) ->
    super()
    @_reloads = []
    @_configuration = cucumber.Cli.Configuration @_args()
    argumentParser = cucumber.Cli.ArgumentParser @_args()
    argumentParser.parse()
    patchHelper = @_patchHelper
    @_configuration.getSupportCodeLibrary = ->
      supportCodeFilePaths = argumentParser.getSupportCodeFilePaths()
      supportCodeLoader = cucumber.Cli.SupportCodeLoader supportCodeFilePaths
      supportCodeLoader._buildSupportCodeInitializerFromPaths =
        supportCodeLoader.buildSupportCodeInitializerFromPaths
      supportCodeLoader.buildSupportCodeInitializerFromPaths = (paths) ->
        wrapper = supportCodeLoader._buildSupportCodeInitializerFromPaths paths
        # coffeelint: disable=missing_fat_arrows
        ->
          patchHelper this
          wrapper.call this
        # coffeelint: enable=missing_fat_arrows
      supportCodeLoader.getSupportCodeLibrary()

  _patchHelper: (helper) ->
    return if helper._patched?
    helper._patched = true
    helper._defineStep = helper.defineStep
    helper.defineStep = (name, code) ->
      helper._defineStep name, Cucumber.Util.bindEnv code
    helper.Given = helper.When = helper.Then = helper.defineStep
    for type in ['Around', 'Before', 'After']
      do (type) ->
        helper["_define#{type}Hook"] = helper["define#{type}Hook"]
        helper["define#{type}Hook"] = (args..., code) ->
          helper["_define#{type}Hook"] args..., Cucumber.Util.bindEnv code

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
    @_disrequire file for file in reloads

  _disrequire: (file) -> delete Module._cache[file] if Module._cache[file]?
