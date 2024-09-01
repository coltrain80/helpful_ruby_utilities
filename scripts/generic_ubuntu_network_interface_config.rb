#!/usr/bin/env ruby
# network_interface_config_template.rb
# Template script for configuring a network interface on Ubuntu 22.04.
# This script allows users to configure network settings for a specific interface by providing the necessary options.
#
# Usage:
#   Run the script with appropriate command-line arguments or modify it for interactive use.
#   Example: ruby network_interface_config_template.rb --interface=ens33 --ip_address=192.168.1.10 --subnet_mask=255.255.255.0 --gateway=192.168.1.1
#
# Arguments:
#   --interface: Name of the network interface to configure (required)
#   --ip_address: IP address to assign to the interface (required)
#   --subnet_mask: Subnet mask for the network (required)
#   --gateway: Default gateway for the network (optional)
#
# Examples:
#   - Configure an interface with an IP address:
#     ruby network_interface_config_template.rb --interface=ens33 --ip_address=192.168.1.10 --subnet_mask=255.255.255.0 --gateway=192.168.1.1

require 'optparse'

# Helper function to convert subnet mask to CIDR notation
def mask_to_cidr(mask)
  mask.split('.').map(&:to_i).inject(0) { |a, e| (a << 8) + e.to_s(2).count('1') }
end

# Parse command-line arguments
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: network_interface_config_template.rb [options]"

  opts.on("--interface=INTERFACE", "Name of the network interface to configure (required)") do |v|
    options[:interface] = v
  end

  opts.on("--ip_address=IP", "IP address to assign to the interface (required)") do |v|
    options[:ip_address] = v
  end

  opts.on("--subnet_mask=MASK", "Subnet mask for the network (required)") do |v|
    options[:subnet_mask] = v
  end

  opts.on("--gateway=GATEWAY", "Default gateway for the network (optional)") do |v|
    options[:gateway] = v
  end
end.parse!

# Ensure required options are provided
if options[:interface].nil? || options[:ip_address].nil? || options[:subnet_mask].nil?
  puts "Missing required arguments. Use --help for more information."
  exit
end

# Convert subnet mask to CIDR notation
cidr = mask_to_cidr(options[:subnet_mask])

# Function to configure the network interface
def configure_network_interface(interface, ip_address, cidr, gateway = nil)
  puts "Configuring network interface #{interface}..."

  # Example command to bring the interface down
  system("sudo ip link set #{interface} down")

  # Example command to set the IP address and subnet mask
  system("sudo ip addr add #{ip_address}/#{cidr} dev #{interface}")

  # Example command to bring the interface up
  system("sudo ip link set #{interface} up")

  # Configure the default gateway if provided
  if gateway
    puts "Setting default gateway to #{gateway}..."
    system("sudo ip route add default via #{gateway} dev #{interface}")
  end

  puts "Network interface #{interface} configured successfully."
end

# Main script execution
begin
  configure_network_interface(
    options[:interface],
    options[:ip_address],
    cidr,
    options[:gateway]
  )

  puts "Network interface configuration completed successfully."

rescue => e
  puts "An error occurred during network configuration: #{e.message}"
  exit 1
end
