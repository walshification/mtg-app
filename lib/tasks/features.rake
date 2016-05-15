require_relative "../../config/environment"

begin
  desc "run functional tests"
  RSpec::Core::RakeTask.new(:features) do |t|
    t.rspec_opts = "--default-path features"
    t.pattern = "features/**/*_spec.rb"
  end
rescue NameError
end
