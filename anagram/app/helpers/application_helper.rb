module ApplicationHelper
	def word_form_method(word)
		if word.new_record?
			@method = "post"
		else
			@method = "put"
		end
		@method
	end
	
	def word_form_action(word)
		if word.new_record?
			@action = "/words"
		else
			@action = "/words/#{word.id}"
		end
		@action
	end
	
	def word_form_id(word)
		if word.new_record?
			@id = "new-word"
		else
			@id = "word-#{word.id}"
		end
		@id
	end
end
