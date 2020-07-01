namespace :yarn do
  desc 'TODO'
  task :disable do
    # Hack: prevent the yarn install task from running
    Rake::Task['yarn:install'].clear
  end
end
