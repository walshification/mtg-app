# frozen_string_literal: true

# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  task :set_annotation_options do
    # You can override any of these by setting an environment variable of the
    # same name.
    Annotate.set_defaults(
      'position_in_routes'   => 'bottom',
      'position_in_class'    => 'bottom',
      'position_in_test'     => 'bottom',
      'position_in_fixture'  => 'bottom',
      'position_in_factory'  => 'bottom',
      'show_indexes'         => 'true',
      'simple_indexes'       => 'false',
      'model_dir'            => 'app/models',
      'include_version'      => 'false',
      'require'              => '',
      'exclude_tests'        => 'true',
      'exclude_fixtures'     => 'true',
      'exclude_factories'    => 'false',
      'ignore_model_sub_dir' => 'false',
      'skip_on_db_migrate'   => 'false',
      'format_bare'          => 'false',
      'format_rdoc'          => 'true',
      'format_markdown'      => 'false',
      'sort'                 => 'false',
      'force'                => 'false',
      'trace'                => 'false'
    )
  end

  Annotate.load_tasks
end
