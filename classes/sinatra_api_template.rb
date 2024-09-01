# api_template.rb
=begin
Generic API Template using Sinatra
----------------------------------

This script sets up a basic API using Sinatra, a popular Ruby web framework.
It defines a generic API class with endpoints that can be extended as needed.

Quick Reference for Expanding the API:
--------------------------------------

1. **Adding New Routes:**
   - To add a new endpoint, define a new route within the `GenericAPI` class.
   - Example:
     get '/new_endpoint' do
       # Define the logic for this endpoint
       json message: "This is a new endpoint"
     end

2. **Encapsulating Further with New Classes:**
   - Create additional classes or modules to handle different parts of the API (e.g., separate controllers for different resources).
   - Example:
     class UserAPI < Sinatra::Base
       get '/users' do
         # Logic for handling users
         json users: []
       end
     end

3. **Adding New Methods:**
   - Define new helper methods within the `GenericAPI` class or any new class to encapsulate functionality.
   - Example:
     def process_data(data)
       # Perform operations on data
       data_processed
     end

4. **Integrating Database:**
   - Use ActiveRecord or another ORM to interact with a database.
   - Example:
     require 'active_record'
     ActiveRecord::Base.establish_connection(...)

5. **Implementing Error Handling:**
   - Add error handlers to manage exceptions and return appropriate HTTP status codes.
   - Example:
     error Sinatra::NotFound do
       json error: "Not Found"
     end

6. **Adding Middleware:**
   - Use middleware for cross-cutting concerns like logging, authentication, etc.
   - Example:
     use Rack::Logger

7. **Authentication and Authorization:**
   - Integrate JWT, OAuth2, or another method to protect routes.
   - Example:
     require 'jwt'

Usage:
    1. Install Sinatra if not already installed: gem install sinatra
    2. Run the script: ruby api_template.rb
    3. Access the API at http://localhost:4567/

Example:
    You can use this template to build your own API by extending the GenericAPI class.
=end

require 'sinatra'
require 'sinatra/json'

class GenericAPI < Sinatra::Base
  # Configure Sinatra settings
  configure do
    set :bind, '0.0.0.0'
    set :port, 4567
  end

  # Example GET endpoint
  get '/' do
    json message: "Welcome to the Generic API!"
  end

  # Example GET endpoint to retrieve data
  get '/data' do
    sample_data = { id: 1, name: "Sample Data", description: "This is some sample data." }
    json sample_data
  end

  # Example POST endpoint to create data
  post '/data' do
    data = JSON.parse(request.body.read)
    json data
  end

  # Example PUT endpoint to update data
  put '/data/:id' do
    data_id = params[:id]
    updated_data = JSON.parse(request.body.read)
    updated_data['id'] = data_id
    json updated_data
  end

  # Example DELETE endpoint to delete data
  delete '/data/:id' do
    data_id = params[:id]
    json message: "Data with ID #{data_id} deleted successfully."
  end

  # Start the Sinatra server if this file is run directly
  run! if app_file == $0
end
