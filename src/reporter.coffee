

class Cucumber.Reporter

  constructor: ->
    @_bound_report = Meteor.bindEnvironment => @_report arguments...

  report: (result) -> @_bound_report result
