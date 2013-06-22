class Hangman

end

class HumanPlayer
	attr_accessor :word, :word_state


	# Check winning guess when human is hangman (full word guesses)
	def winning_guess?(guess)
		print "Is #{guess} your word?"
		answer = gets.chomp
		if answer == "yes"
			return "GUESSER WINS"
		else
			return "THAT'S NOT IT"
		end
	end
end

class ComputerPlayer
	attr_accessor :word, :word_state

	# Guess is single letter
	# Check if letter is in word
	def evaluate_guess(guess)
		letters = self.word.split(//)
		letter_locations = []
		letters.each_with_index do |letter, index|
			if letter == guess
				letter_locations << index
			end
		end
	end

	# Check winning guess when computer is hangman (full word guesses)
	def winning_guess?(guess)
		if guess == word
			return "GUESSER WINS"
		else
			return "THAT'S NOT IT"
	end
end

# Check for winning guess if guess.length > 1