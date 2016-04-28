class Word < ActiveRecord::Base
	before_save :add_letters
	
	def add_letters
		characters = self.text.downcase.chars
		alphabetized_characters = characters.sort
		self.letters = alphabetized_characters.join
	end
	
	def self.find_anagrams(word)
		anagrams = []
		word_array = word.downcase.split(//) # place the characters of the word into an array
		combinations = word_array.permutation.map{ |i| i.join } # joins the 3 character array with all permutations and inserts each into output array.
		
		combinations.each do |potential|
			if Word.find_by_text(potential).present?
				anagrams << potential
			end
		end
		
		anagrams
	end
end