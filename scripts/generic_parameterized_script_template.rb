# command_line_script.rb
# This script template allows users to input parameters via command line arguments.
#
# Usage:
#   Run the script with command line arguments (e.g., ruby command_line_script.rb arg1 arg2)
#
# Example:
#   $ ruby command_line_script.rb hello world
#   Output: Your inputs were hello and world

# Check if the correct number of arguments is provided
if ARGV.length != 2
    puts "Usage: ruby command_line_script.rb <parameter1> <parameter2>"
    exit
  end
  
  parameter1 = ARGV[0]
  parameter2 = ARGV[1]
  
  puts "Your inputs were #{parameter1} and #{parameter2}"
  