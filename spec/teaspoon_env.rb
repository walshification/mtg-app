# frozen_string_literal: true

Teaspoon.configure do |config|
  # Determines where the Teaspoon routes will be mounted.
  # Changing this to '/jasmine' would allow you to browse to
  # `http://localhost:3000/jasmine` to run your tests.
  config.mount_at = '/teaspoon'

  # Specifies the root where Teaspoon will look for files.
  # If you're testing an engine using a dummy application it can
  # be useful to set this to your engines root (e.g. `Teaspoon::Engine.root`).
  # Note: Defaults to `Rails.root` if nil.
  config.root = nil

  # Paths that will be appended to the Rails assets paths
  # Note: Relative to `config.root`.
  config.asset_paths = ['spec/javascripts', 'spec/javascripts/stylesheets']

  # Fixtures are rendered through a controller, which allows using HAML,
  # RABL/JBuilder, etc. Files in these paths will
  # be rendered as fixtures.
  config.fixture_paths = ['spec/javascripts/fixtures']

  # SUITES
  #
  # You can modify the default suite configuration and create new suites here.
  # Suites are isolated from one another.
  #
  # When defining a suite you can provide a name and a block.
  # If the name is left blank, :default is assumed. You can
  # omit various directives and the ones defined in the default suite will be used.
  #
  # To run a specific suite
  # - in the browser: http://localhost/teaspoon/[suite_name]
  # - with the rake task: rake teaspoon suite=[suite_name]
  # - with the cli: teaspoon --suite=[suite_name]
  config.suite do |suite|
    # Specify the framework you would like to use.
    # This allows you to select versions, and will do some basic setup for
    # you -- which you can override with the directives below.
    # This should be specified first, as it can override other directives.
    # Note: If no version is specified, the latest is assumed.
    #
    # Versions: 1.3.1, 2.0.3, 2.1.3, 2.2.0, 2.2.1, 2.3.4
    suite.use_framework :jasmine, '2.3.4'

    # Specify a file matcher as a regular expression and all matching files will be
    # loaded when the suite is run. These files need to be within an asset path.
    # You can add asset paths using the `config.asset_paths`.
    suite.matcher = '{spec/javascripts,app/assets}/**/*_spec.{js,js.coffee,coffee}'

    # Load additional JS files, but requiring them in your spec helper is the
    # preferred way to do this.
    # suite.javascripts = []

    # You can include your own stylesheets if you want to change how Teaspoon looks.
    # Note: Spec related CSS can and should be loaded using fixtures.
    # suite.stylesheets = ['teaspoon']

    # This suites spec helper, which can require additional support files.
    # This file is loaded before any of your test files are loaded.
    suite.helper = 'spec_helper'

    # Partial to be rendered in the head tag of the runner.
    # You can use the provided ones or define your own by creating a `_boot.html.erb`
    # in your fixtures path, and adjust the config to `'/boot'` for instance.
    #
    # Available: boot, boot_require_js
    suite.boot_partial = 'boot'

    # Partial to be rendered in the body tag of the runner.
    # You can define your own to create a custom body structure.
    suite.body_partial = 'body'

    # Hooks allow you to use `Teaspoon.hook('fixtures')` before, after, or during
    # your spec run. This will make a synchronous Ajax request to the server that
    # will call all of the blocks you've defined for that hook name.
    # suite.hook :fixtures, &proc{}

    # Determine whether specs loaded into the test harness should be embedded as
    # individual script tags or concatenated into a single file.
    # Similar to Rails' asset `debug: true` and `config.assets.debug = true` options.
    # By default, Teaspoon expands all assets to provide more valuable stack
    # traces that reference individual source files.
    # suite.expand_assets = true

    # Non-.js file extensions Teaspoon should consider JavaScript files
    # suite.js_extensions = [/(\.js)?.coffee/, /(\.js)?.es6/, '.es6.js']
  end

  config.coverage do |coverage|
  end
end
