
module.exports = ->

  @World = class MultiWorld extends Cucumber.World

    constructor: ->
      @zombie = new Cucumber.World.Zombie
      @selenium = new Cucumber.World.Selenium if Package.selenium?
      @protractor = new Cucumber.World.Protractor if Package.selenium?
      super
