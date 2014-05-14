
Package.describe({
  summary: 'CucumberJS test runner and Velocity reporter'
});

Npm.depends({
  'cucumber': '0.4.0',
  'chokidar': '0.8.2',
  'zombie': '2.0.0-alpha31',
  'protractor': '0.22.0',
  'disrequire': 'https://github.com/xdissent/disrequire/archive/v0.0.0.tar.gz' +
    '#a39214c33c8e4c3a839e4f38b7e8c162b6220ab1'
});

Package.on_use(function (api) {
  api.use(['underscore', 'coffeescript'], 'server');

  api.use('webapp', 'server', {weak: true});
  api.use('selenium', 'server', {weak: true});
  api.use('velocity', 'server', {weak: true});
  api.use('mirror', 'server', {weak: true});

  api.add_files('src/index.coffee', 'server');

  api.add_files('src/settings.coffee', 'server');

  api.add_files('src/util.coffee', 'server');

  api.add_files('src/world.coffee', 'server');
  api.add_files('src/world/selenium.coffee', 'server');
  api.add_files('src/world/protractor.coffee', 'server');
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
