#!/usr/bin/env ruby
# postgres_setup.rb
# This script installs PostgreSQL on Ubuntu, configures it with initial settings,
# and creates a generic database.
#
# Usage:
#   Run the script with sudo or as a root user to install and configure PostgreSQL.
#
# Example:
#   sudo ruby postgres_setup.rb

# Check if the user is root
if Process.uid != 0
    puts "This script must be run as root. Please use sudo."
    exit 1
  end
  
  # Function to run a system command and handle errors
  def run_command(command)
    puts "Running: #{command}"
    unless system(command)
      puts "Command failed: #{command}"
      exit 1
    end
  end
  
  # Step 1: Update the package list
  run_command("apt-get update")
  
  # Step 2: Install PostgreSQL
  run_command("apt-get install -y postgresql postgresql-contrib")
  
  # Step 3: Start PostgreSQL service
  run_command("systemctl start postgresql")
  
  # Step 4: Enable PostgreSQL service to start on boot
  run_command("systemctl enable postgresql")
  
  # Step 5: Set up initial PostgreSQL configuration
  # (This example sets a basic password for the default postgres user and creates a new database)
  def configure_postgres
    # Define variables for the initial setup
    postgres_password = "password123" # Replace with a secure password
    database_name = "generic_db"
    user_name = "generic_user"
    user_password = "user_password" # Replace with a secure password
  
    # Commands to configure PostgreSQL
    commands = [
      # Switch to the postgres user
      "sudo -u postgres psql -c \"ALTER USER postgres PASSWORD '#{postgres_password}';\"",
      
      # Create a new PostgreSQL role with a password
      "sudo -u postgres psql -c \"CREATE ROLE #{user_name} WITH LOGIN PASSWORD '#{user_password}';\"",
  
      # Create a new PostgreSQL database owned by the new role
      "sudo -u postgres psql -c \"CREATE DATABASE #{database_name} OWNER #{user_name};\"",
  
      # Grant all privileges on the database to the user
      "sudo -u postgres psql -c \"GRANT ALL PRIVILEGES ON DATABASE #{database_name} TO #{user_name};\""
    ]
  
    # Run each command to configure PostgreSQL
    commands.each do |command|
      run_command(command)
    end
  end
  
  # Run PostgreSQL configuration
  configure_postgres
  
  puts "PostgreSQL installed and configured successfully."
  puts "Database 'generic_db' created with user 'generic_user'."
  