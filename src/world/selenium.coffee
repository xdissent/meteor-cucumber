

class Cucumber.World.Selenium extends Cucumber.World

  constructor: ->
    throw new Error 'Selenium package required' unless Package.selenium?
    @selenium = Package.selenium.Selenium
    @driver = @selenium.driver()
    @webdriver = @selenium.webdriver
    @by = @selenium.webdriver.By
    super

  home: -> @driver.get @root_url
