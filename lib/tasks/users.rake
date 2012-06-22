namespace :users do
  task :follow_again => :environment do
    p"==========TASK====="
    Friend.follow_again
  end
end