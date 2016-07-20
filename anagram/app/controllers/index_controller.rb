get '/' do
	erb :index
end

get '/anagrams/:word' do
	@word = params[:word]
	alphabetized_string = @word.downcase.chars.sort.join
	@anagrams = Word.where("letters=?", alphabetized_string)
	#@anagrams = Word.find_anagrams(@word)
	erb :show
end

post '/' do
	@word = params[:word]
	begin
		valid_input("#{@word}")
		#distinct_letters("#{@word}")
		redirect "/anagrams/#{@word}"
	rescue Exception => error
		@error = error.message
		erb :index
	end
end

def distinct_letters(input)
	letter_array = input.chars
	unique_letters = letter_array.uniq
	
	if unique_letters.length < letter_array.length
		raise Exception.new("You have repeating letters! This is not allowed.")
	end
end

def valid_input(input)
	if !input[/[a-zA-Z]+/] == input
		raise Exception.new("Word must be alpha characters only.")
	end
end