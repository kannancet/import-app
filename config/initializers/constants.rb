IMPORT_OPERATION_FILE = "#{Rails.root}/public/ImporterAppExample.csv"
DATE_FORMATS = [
				{format: /^\d{2}\/\d{2}\/\d{4}$/, type: '%m/%d/%Y'}, 
				{format: /^\d{4}-\d{2}-\d{2}$/, type: '%Y-%m-%d'}, 
				{format: /^\d{2}-\d{2}-\d{4}$/, type: '%d-%m-%Y'}
			   ]

OPERATION_IMPORT_LOG = "#{Rails.root}/log/operation_import.log"