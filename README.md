cucumber
========


Example
-------

```sh
$ git clone https://github.com/xdissent/meteor-cucumber.git
$ cd meteor-cucumber/example
$ mrt
```


Meteor Settings
---------------

```coffee
cucumber:

  # Enable cucumber package
  enabled: true

  # Print debug messages
  debug: false

  # Run tests at startup
  startup: true

  # Run tests when files change
  watch: true

  # Path to features
  path: 'tests/features'

  # Cucumber formatter for console output
  format: 'pretty'

  # Print snippets for missing step definitions in Coffeescript
  coffee: false

  # Run tests with the given tags
  tags: []

  # Enable velocity support (https://github.com/xolvio/velocity)
  velocity: true

  # Enable mirror support (https://github.com/xdissent/meteor-mirror)
  mirror: true
  
  # Run the tests on the remote app instance if mirroring
  remote: true
```