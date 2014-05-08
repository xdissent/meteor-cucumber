

# Runs tests locally on a mirror, reporting back via subscribe/publish
class Cucumber.Runner.Mirror extends Cucumber.Runner.Local
  
  constructor: ->
    super
    @mirror.subscribe (msg) =>
      @reload msg.file if msg?.command is 'reload'
      return unless msg?.command is 'run'
      @run (err, result) =>
        result = 'error' if err?
        @mirror.publish id: msg.id, result: result

  _startMirror: (callback) -> callback null
