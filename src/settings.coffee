
path = Npm.require 'path'

Cucumber.settings = settings = _.clone Meteor.settings.cucumber ? {}

_.defaults settings,
  enabled: true
  format: 'pretty'
  startup: true
  debug: false
  path: path.join process.env.PWD, 'tests/features'
  mirror: Package.mirror?
  watch: true
  velocity: Package.velocity?
  coffee: false
  tags: []

settings.remote ?= settings.mirror

if settings.remote and not settings.mirror
  throw new Error 'Cannot have remote setting without mirror setting'

if settings.remote and not Package.mirror?
  throw new Error 'Cannot have remote setting without mirror package'

if settings.mirror and not Package.mirror?
  throw new Error 'Cannot have mirror setting without mirror package'
