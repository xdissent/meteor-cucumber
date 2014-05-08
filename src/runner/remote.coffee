

# Runs tests remotely via subscribe/publish
class Cucumber.Runner.Remote extends Cucumber.Runner

  constructor: (@mirror) -> super

  reload: (file) -> @mirror.publish command: 'reload', file: file

  _pipe: (src, dest) ->
    piped = false
    _pipe = ->
      piped = true
      src.pipe dest
    switch src._readableState.pipesCount
      when 0 then _pipe()
      when 1 then _pipe() unless src._readableState.pipes is dest
      else _pipe() unless dest in src._readableState.pipes
    piped

  _run: (callback) ->
    @mirror.start (err) =>
      return callback err if err?
      id = Date.now()
      piped = @_pipe @mirror.child.stdout, process.stdout

      cleanup = =>
        clearTimeout timeout
        @mirror.unsubscribe subscription
        @mirror.child.stdout.unpipe process.stdout if piped

      timeout = setTimeout ->
        cleanup()
        callback new Error 'Remote run timed out'
      , 60000 # XXX Make this a setting and add to other runners

      subscription = (msg) ->
        return unless msg?.id is id
        cleanup()
        return callback new Error 'Remote error' if msg.result is 'error'
        callback null, msg.result

      @mirror.subscribe subscription
      @mirror.publish id: id, command: 'run'
