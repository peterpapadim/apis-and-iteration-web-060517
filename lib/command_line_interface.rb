def welcome
  # puts out a welcome message here!
  puts "Tell me your favorite Star Wars Character and I'll tell you what films they were in."
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp.downcase
end
