

class Cucumber.World.Zombie extends Cucumber.World

  constructor: ->
    @zombie = Npm.require 'zombie'
    @browser = new @zombie
    super

  home: (callback) -> @browser.visit @root_url, callback
