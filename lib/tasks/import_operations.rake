=begin
  This task to import all operations from CSV.
  Models - Operations, Category
=end

namespace :import do
  
  desc "Process to import operations from CSV."
  task :operations => :environment do
    
    puts "Importing operations data ..."
    Operation.import
  end
  
end