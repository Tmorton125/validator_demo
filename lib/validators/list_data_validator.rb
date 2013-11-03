class ListDataValidator < ActiveModel::EachValidator


  # Demo Use of validators
  # if data in column is separated by a value verifys data is in proper format
  # ex. | name1 | name2 | etc |


  def validate_each(record, attribute, value)
  
  	# OPTIONALS
  	#  LIMIT - MAX NUMBER OF ENTRIES
  	#  REGEX - regex to compare the values against ie all values must contain a number
	
  	# TODO - Localize error messages
  	if !value.nil?

  		separator = options[:token]
  		limit = options[:limit].to_s.to_i(10)
  		regex = options[:regex]


  		if !separator.blank?

  			split_values = value.split(separator)

  			
  			if limit > 0 and split_values.length > limit
  				record.errors.add(attribute, "contains too many data points maximum number of values is #{limit}")
  			end

  			if !regex.blank?

  				split_values.each do |item|

  					if item.match(regex).blank?
  						record.errors.add(attribute, "did not meet required format for value [#{item}]")
  					end

  				end
  			end
  		else
  			record.errors.add(attribute,'unable to be verified')
  		end



  	end		
  end



end