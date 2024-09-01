# SystemdJobScheduler.rb
# This class generates and schedules systemd jobs by creating and enabling service and timer files.
# It uses Ruby's File I/O to create systemd service and timer unit files based on user-provided information.
#
# Usage:
#   1. Instantiate the class with the required information.
#   2. Call the `create_service` method to generate a systemd service file.
#   3. Call the `create_timer` method to generate a systemd timer file.
#   4. Call the `enable_and_start_timer` method to enable and start the timer.
#
# Example:
#   scheduler = SystemdJobScheduler.new("my_job", "/path/to/command.sh", "OnCalendar=daily")
#   scheduler.create_service
#   scheduler.create_timer
#   scheduler.enable_and_start_timer

class SystemdJobScheduler
    attr_accessor :job_name, :command, :schedule
  
    # Initialize the class with the job name, command, and schedule
    def initialize(job_name, command, schedule)
      @job_name = job_name
      @command = command
      @schedule = schedule
    end
  
    # Method to create a systemd service file
    def create_service
      service_content = <<-SERVICE
  [Unit]
  Description=#{@job_name} Service
  
  [Service]
  Type=simple
  ExecStart=#{@command}
  SERVICE
  
      service_path = "/etc/systemd/system/#{@job_name}.service"
      
      File.open(service_path, 'w') do |file|
        file.write(service_content)
      end
  
      puts "Systemd service file created at #{service_path}"
    end
  
    # Method to create a systemd timer file
    def create_timer
      timer_content = <<-TIMER
  [Unit]
  Description=#{@job_name} Timer
  
  [Timer]
  #{@schedule}
  
  [Install]
  WantedBy=timers.target
  TIMER
  
      timer_path = "/etc/systemd/system/#{@job_name}.timer"
      
      File.open(timer_path, 'w') do |file|
        file.write(timer_content)
      end
  
      puts "Systemd timer file created at #{timer_path}"
    end
  
    # Method to enable and start the systemd timer
    def enable_and_start_timer
      system("sudo systemctl daemon-reload")
      system("sudo systemctl enable #{@job_name}.timer")
      system("sudo systemctl start #{@job_name}.timer")
  
      puts "Systemd timer #{@job_name} enabled and started."
    end
  end
  
  # Example usage:
  # scheduler = SystemdJobScheduler.new("my_job", "/path/to/command.sh", "OnCalendar=daily")
  # scheduler.create_service
  # scheduler.create_timer
  # scheduler.enable_and_start_timer
  