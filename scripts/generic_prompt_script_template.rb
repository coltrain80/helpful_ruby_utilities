# interactive_script.rb
# This script template allows users to input parameters via an interactive prompt.
#
# Usage:
#   Run the script in a Ruby environment (e.g., ruby interactive_script.rb)
#   Follow the prompts to input your parameters.
#
# Example:
#   $ ruby interactive_script.rb
#   Enter first parameter: hello
#   Enter second parameter: world
#   Output: Your inputs were hello and world

puts "Enter first parameter:"
parameter1 = gets.chomp

puts "Enter second parameter:"
parameter2 = gets.chomp

puts "Your inputs were #{parameter1} and #{parameter2}"
