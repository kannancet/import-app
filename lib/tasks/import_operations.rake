=begin
  This task to import all operations from CSV.
  Models - Operations, Category
=end

namespace :import do
  
  desc "Process to import operations from CSV."
  task :operations => :environment do
  	#begin 
      puts "Importing operations data ..."
      Operation.import
    # rescue Exception => e
    #   p e.message
    # end
  end
  
end