
module.exports = ->

  return unless Package.selenium?

  @Given /^I am a website visitor using protractor$/, (callback) ->
    callback()

  @When /^I go to the home page with protractor$/, (callback) ->
    @protractor.browser.get('ng.html').then callback, callback

  @Then 'I should see "$text" using protractor', (text, callback) ->
    @protractor.browser.getPageSource().then (source) ->
      return callback() unless -1 is source.indexOf text 
      callback new Error "Expected to find #{text} on page"
    , callback
