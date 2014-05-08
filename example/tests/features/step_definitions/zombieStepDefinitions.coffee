
module.exports = ->

  @Given /^I am a website visitor using zombie$/, (callback) ->
    callback()

  @When /^I go to the home page with zombie$/, (callback) ->
    @zombie.home callback

  @Then 'I should see "$text" using zombie', (text, callback) ->
    source = @zombie.browser.html()
    return callback() unless -1 is source.indexOf text 
    callback new Error "Expected to find #{text} on page"
