
ZombieBrowser = Npm.require 'zombie'


class Cucumber.World.Zombie extends Cucumber.World

  constructor: ->
    @browser = new @constructor.Browser
    super

  home: (callback) -> @browser.visit @root_url, callback


class Cucumber.World.Zombie.Browser extends ZombieBrowser

  wait: (options, callback) ->
    if !callback? and 'function' is typeof options
      [callback, options] = [options, null]
    return super options, callback unless callback?
    super options, Cucumber.Util.bindEnv callback

  visit: (url, options, callback) ->
    if !callback? and 'function' is typeof options
      [callback, options] = [options, null]
    return super url, options, callback unless callback?
    super url, options, Cucumber.Util.bindEnv callback

  load: (html, callback) ->
    return super unless callback?
    super html, Cucumber.Util.bindEnv callback
