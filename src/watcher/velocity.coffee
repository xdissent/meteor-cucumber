
path = Npm.require 'path'


class Cucumber.Watcher.Velocity extends Cucumber.Watcher

  name: 'Velocity'

  _TestFileCollection: Package.velocity?.VelocityTestFiles

  _callback: ->
    return (-> ) unless Package.velocity?
    Meteor.bindEnvironment (evt, file, stat) =>
      return unless @_isFeature file
      @_debug "Event '#{evt}' for #{file} triggered test file update"
      return @_TestFileCollection.remove _id: file if evt is 'unlink'
      @_TestFileCollection.upsert {_id: file}, @_testFile file, stat
    , (err) => @_debug 'Error in watcher callback', err

  _relativePath: (file) ->
    path.join path.basename(@watch_path), path.relative @watch_path, file

  _path: (file) -> path.dirname @_relativePath file

  _testFile: (file, stat = null) ->
    _id: file
    name: path.basename file
    absolutePath: file
    relativePath: @_relativePath file
    path: @_path file
    targetFramework: 'cucumber'
    lastModified: stat?.mtime?.getTime?() ? Date.now()
