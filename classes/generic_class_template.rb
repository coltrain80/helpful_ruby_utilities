# ClassTemplate.rb
# This is a general template for creating a Ruby class.
# Replace 'ClassName' with your desired class name and add your methods as needed.
#
# Usage:
#   1. Instantiate the class: instance = ClassName.new(optional_parameters)
#   2. Call class methods: instance.method_name(arguments)
#
# Example:
#   person = Person.new('John Doe', 30)
#   puts person.greet

class ClassName
    attr_accessor :attribute1, :attribute2
  
    # Initialize method with default parameter values
    def initialize(attribute1 = 'default1', attribute2 = 'default2')
      @attribute1 = attribute1
      @attribute2 = attribute2
    end
  
    # Example method that uses class attributes
    def example_method
      "This is an example method that uses #{@attribute1} and #{@attribute2}"
    end
  end
  