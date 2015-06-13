#This module implements import data 
module Importable
  extend ActiveSupport::Concern
  
  #All class methods are defined here.
  module ClassMethods

    #Function to import operations from CSV.
    def import
      notify_on_parsing_log

      SmarterCSV.process(IMPORT_OPERATION_FILE) do |data|
        data = data.first
        sync_data(data)
      end
    end

    #Function to sync data
    def sync_data(data)
      begin
        operation = create_operation(data)
        sync_categories(operation) if operation.kind

      rescue Exception => e
        log_data_invalid_error(data, e)
      end
    end

    #Function to find company from name and return company_id
    def find_company_id(name)
      @company = Company.find_or_create_by(name: name)
      @company.id
    end

    #Function to parse data
    def parse_date(date_string)
      selected_format = DATE_FORMATS.select{|date_format| date_string =~ date_format[:format]}[0]
      Date.strptime(date_string, selected_format[:type]) if selected_format
    end

    #Function to sync categories
    def sync_categories(operation)
      category_names = operation.kind.split(";")

      category_names.each do |name| 
        category = find_or_create_category(name)
        category.operations.push(operation)
      end
    end

    #Function to find or create category
    def find_or_create_category(name)
      Category.find_or_create_by(name: name)
    end

    #Notify on parsing log
    def notify_on_parsing_log
      open(OPERATION_IMPORT_LOG, 'a') do |file|
        file.truncate(0)
        file.puts "<<<<<<<<< PARSING LOG AT : #{Time.now} >>>>>>>>>"
      end
    end

    #Function to retrun data invalid error.
    def log_data_invalid_error(data, exception)
      open(OPERATION_IMPORT_LOG, 'a') do |file|

        file.puts "==== DATA INVALID ===="
        file.puts "Skipping Invoice #{data[:invoice_num]} of company #{data[:company]}"
        file.puts "Reason - #{exception.message}"
      end
    end

    #Function to create operation
    def create_operation(data)
      puts "Importing Operation #{data[:invoice_num]}"
      Operation.find_or_create_by(company_id: find_company_id(data[:company]),
                    invoice_num: data[:invoice_num],
                    invoice_date: parse_date(data[:invoice_date]),
                    operation_date: parse_date(data[:operation_date]),
                    amount: data[:amount] || 1.0,
                    reporter: data[:reporter],
                    notes: data[:notes],
                    status: data[:status],
                    kind: data[:kind] 
                    )
    end

  end

end