

class Cucumber.World.Protractor extends Cucumber.World.Selenium

  constructor: ->
    super
    @protractor = Npm.require 'protractor'
    @browser = @protractor.wrapDriver @driver, @root_url
    @by = @By = @protractor.by

  home: -> @browser.get @root_url
