require 'sinatra'

def magic_method(my_number)
	final_number = my_number.to_s
	temp_array = final_number.split("")

	final_number = 0
	temp_array.each { |x| final_number += x.to_i }
	
	return final_number
end

def my_message(number)
	case number.to_s
		when '1' then "One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
		when '2' then "This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
		when '3' then "Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
		when '4' then "This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
		when '5' then "This is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
		when '6' then "This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
		when '7' then "This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
		when '8' then "This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
		when '9' then "This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
	end
end

def setup_index_view(birthdate)
	birthdate = birthdate
	
	@birth_path_num = magic_method(birthdate)
	@birth_path_num = magic_method(@birth_path_num)

	if (@birth_path_num > 9)
		@birth_path_num = magic_method(@birth_path_num)
	end
	
	@message = my_message(@birth_path_num)
end

def valid_birthdate(input)
	if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
		return true
	else
		return false
	end
end

get '/' do
	erb :form
end

get '/message/:birth_path_num' do
	@birth_path_num = params[:birth_path_num].to_i
	@message = my_message(@birth_path_num)
	
	erb :index
end

post '/' do
	birthdate = params[:birthdate].gsub("-", "")
	if valid_birthdate(birthdate)
		setup_index_view(birthdate)
		redirect "/message/#{@birth_path_num}"
	else
		@error = "Invalid entry. Please try again!"
		erb :form
	end
end
