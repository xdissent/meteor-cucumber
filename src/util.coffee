

class Cucumber.Util

  @bindEnv: (fn, handler = null, self = null) ->
    bound = Meteor.bindEnvironment ->
      fn.apply self, arguments
    , handler, self
    # coffeelint: disable=missing_fat_arrows
    ->
      self ?= this
      bound.apply self, arguments
    # coffeelint: enable=missing_fat_arrows
