

class Cucumber.Runner

  constructor: ->
    @_running = false
    @_callbacks = []

  run: (callback) ->
    callback = Meteor.bindEnvironment callback ? ->
    return @_callbacks.push callback if @_running
    @_running = true
    @_run (err, result) =>
      callback err, result
      @_running = false
      @_report result unless err?
      @_runAgain() if @_callbacks.length > 0

  _runAgain: ->
    [callbacks, @_callbacks] = [@_callbacks, []]
    @run (err, result) -> callback err, result for callback in callbacks

  _report: (result) ->
    reporter.report result for n, reporter of Cucumber.reporters

  _run: (callback) -> callback null
