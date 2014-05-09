
module.exports = ->

  return unless Package.selenium?

  @Given /^I am a website visitor using selenium$/, (callback) ->
    callback()

  @When /^I go to the home page with selenium$/, (callback) ->
    @selenium.home().then callback, callback

  @Then 'I should see "$text" using selenium', (text, callback) ->
    @selenium.driver.getPageSource().then (source) ->
      return callback() unless -1 is source.indexOf text 
      callback new Error "Expected to find #{text} on page"
    , callback
