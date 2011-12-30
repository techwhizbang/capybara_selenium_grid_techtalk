vendored_cucumber_bin = Dir["#{File.expand_path(File.dirname(__FILE__))}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
$LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new('ok', 'Run features that should pass') do |t|
      t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'default'
    end

    Cucumber::Rake::Task.new('wip', 'Run features that are being worked on') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'wip'
    end

    # Add a new Thread if there is a new profile in the feature files that
    # you'd like to run in parallel
    @cucumber_profile_categories = [].each do |profile|
      Cucumber::Rake::Task.new(profile, "Run features annotated with @#{profile}") do |t|
        t.binary = vendored_cucumber_bin
        t.fork = true # You may get faster startup if you set this to false
        t.profile = profile
      end
    end

    desc('Run the functional test suite in parallel on your local or on a Selenium Grid enabled CI server')
    task :parallel_tests do

      all_tests_passed = true

      @cucumber_profile_categories.each do |profile|
        Thread.new { system("bundle exec rake cucumber:#{profile}") }
      end

      Thread.list.each do |t|
        # Wait for the thread to finish if it isn't this thread (i.e. the main thread).
        if t != Thread.current
          t.join
          all_tests_passed = false unless t.value
        end
      end

      raise "Some of the functional tests failed" unless all_tests_passed
    end

    Cucumber::Rake::Task.new('rerun', 'Record failing features and run only them if any exist') do |t|
      t.binary = vendored_cucumber_bin
      t.fork = true # You may get faster startup if you set this to false
      t.profile = 'rerun'
    end

    desc 'Run all features'
    task :all => [:ok, :wip]
  end
  desc 'Alias for cucumber:ok'
  task :cucumber => 'cucumber:ok'

  task :default => :cucumber
rescue LoadError
  desc 'cucumber rake task not available (cucumber not installed)'
  task :cucumber do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end
