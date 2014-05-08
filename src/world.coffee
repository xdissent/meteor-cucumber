

class Cucumber.World

  constructor: (callback) ->
    @root_url = Cucumber.mirror?.root_url ? process.env.ROOT_URL
    callback() if callback?
