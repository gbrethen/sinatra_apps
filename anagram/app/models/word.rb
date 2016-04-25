class Word
	def self.find_anagrams(word)
		word_array = word.downcase.split(//) # place the characters of the word into an array
		anagrams = word_array.permutation.map{ |i| i.join } # joins the 3 character array with all permutations and inserts each into output array.
		
		anagrams
	end
end