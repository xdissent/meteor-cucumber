

class Cucumber.Reporter.Velocity extends Cucumber.Reporter

  _report: (result) ->
    Package.velocity.VelocityAggregateReports.upsert _id: 'cucumber',
      _id: 'cucumber'
      name: 'Cucumber Result'
      result: result.result
    Meteor.call 'resetReports', framework: 'cucumber'
    for feature in result.features
      for scenario in feature.elements
        for step in scenario.steps
          Meteor.call 'postResult',
            id: "#{scenario.id}-#{step.line}"
            name: step.name
            framework: 'cucumber'
            result: step.result.status
            timestamp: (new Date).toISOString().replace(/\.\d*Z$/, '')
            time: (step.result.duration ? 0) / 1000000000.0
            ancestors: [feature.name, scenario.name]
