

class Cucumber.Watcher.Rerun extends Cucumber.Watcher

  name: 'Rerun'

  _options: -> ignoreInitial: true

  _callback: ->
    Meteor.bindEnvironment (evt, file, stat) =>
      return unless @_isCode(file) or @_isFeature file
      @_debug "Event '#{evt}' for #{file} triggered test run"
      Cucumber.runner.reload file
      Cucumber.run (err, succeeded) =>
        result = if succeeded then 'passed' else 'failed'
        @_debug "Run triggered by '#{evt}' for #{file} #{result}"
    , (err) => @_debug 'Error in watcher callback', err
