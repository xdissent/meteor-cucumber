
Package.describe({
  summary: 'CucumberJS test runner and Velocity reporter'
});

Npm.depends({
  'cucumber': '0.4.0',
  'chokidar': '0.8.2',
  'zombie': '2.0.0-alpha31'
});

Package.on_use(function (api) {
  api.use(['underscore', 'coffeescript'], 'server');

  api.use('webapp', 'server', {weak: true});
  api.use('velocity', 'server', {weak: true});
  api.use('mirror', 'server');

  api.add_files('src/index.coffee', 'server');

  api.add_files('src/settings.coffee', 'server');

  api.add_files('src/util.coffee', 'server');

  api.add_files('src/world.coffee', 'server');
  api.add_files('src/world/zombie.coffee', 'server');

  api.add_files('src/reporter.coffee', 'server');
  api.add_files('src/reporter/velocity.coffee', 'server');

  api.add_files('src/watcher.coffee', 'server');
  api.add_files('src/watcher/velocity.coffee', 'server');
  api.add_files('src/watcher/rerun.coffee', 'server');

  api.add_files('src/runner.coffee', 'server');
  api.add_files('src/runner/local.coffee', 'server');
  api.add_files('src/runner/remote.coffee', 'server');
  api.add_files('src/runner/mirror.coffee', 'server');

  api.add_files('src/main.coffee', 'server');

  api.export('Cucumber', 'server');
});
