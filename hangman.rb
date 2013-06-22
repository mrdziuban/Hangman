class Hangman

end

class HumanPlayer
	attr_accessor :word, :word_state

	# Prompt for a guess
	# Return guess
	def make_guess
		print "Enter a letter or word to guess: "
		gets.chomp
	end

	# Guess is single letter
	# Ask if letter is in word
	# Return locations or "no" if not included
	def evaluate_guess(guess)
		print "Is #{guess} included in your word?"
		answer = gets.chomp
		if answer == "no"
			return "no"
		elsif answer == "yes"
			print "At what indices? (format '1 2 3') "
		letter_locations = gets.chomp.split(" ").map {|i| i.to_i}
		letter_locations
	end

	# Check winning guess when human is hangman (full word guesses)
	def winning_guess?(guess)
		print "Is #{guess} your word?"
		answer = gets.chomp
		if answer == "yes"
			return true
		else
			return false
		end
	end
end

class ComputerPlayer
	LETTERS = ("a".."z").to_a.map {|x| x.to_sym}

	attr_accessor :word, :word_state, :dictionary


	# Create dictionary from dictionary.txt file
	def initialize
		@dictionary = File.readlines("dictionary.txt").map {|word| word.strip}
		@dictionary.map! {|word| word.gsub(/[^a-z]/, "")}
	end

	# Make a guess based on dictionary words
	# Return guess
	def make_guess
		letter_occurrences = []
		if self.dictionary.length > 1
			LETTERS.each do |letter|
				letter_count = 0
				self.dictionary.each do |word|
					letter_count += word.count(letter.to_s)
				end
				letter_occurrences << letter_count
			end
			most_frequent = letter_occurrences.max
			return LETTERS[letter_occurrences.index(most_frequent)].to_s
		else
			return self.dictionary[0]
		end
	end

	# Guess is single letter
	# Check if letter is in word
	# Return locations or "no" if not included
	def evaluate_guess(guess)
		letters = self.word.split(//)
		letter_locations = []
		letters.each_with_index do |letter, index|
			if letter == guess
				letter_locations << index
			end
		end
		if letter_locations.length == 0
			return "no"
		else
			return letter_locations
		end
	end

	# Check winning guess when computer is hangman (full word guesses)
	def winning_guess?(guess)
		if guess == word
			return true
		else
			return false
	end
end

# Check for winning guess if guess.length > 1