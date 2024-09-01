#ssl_cert_generator.rb
# This class generates a Certificate Signing Request (CSR) for SSL certificates.
# It uses the OpenSSL library to create the CSR based on user-provided information.
#
# Usage:
#   1. Instantiate the class with required information.
#   2. Call the `generate_csr` method to create the CSR.
#   3. Optionally, write the CSR to a file.
#
# Example:
#   csr_generator = CsrGenerator.new("example.com", "US", "California", "San Francisco", "Example Corp", "IT", "admin@example.com")
#   csr = csr_generator.generate_csr
#   csr_generator.write_csr_to_file("example.csr", csr)

require 'openssl'

class CsrGenerator
  attr_accessor :common_name, :country, :state, :city, :organization, :organizational_unit, :email

  # Initialize the class with the certificate details
  def initialize(common_name, country, state, city, organization, organizational_unit, email)
    @common_name = common_name
    @country = country
    @state = state
    @city = city
    @organization = organization
    @organizational_unit = organizational_unit
    @email = email
  end

  # Method to generate a CSR
  def generate_csr
    # Generate a new private key
    key = OpenSSL::PKey::RSA.new(2048)

    # Create a new request for the certificate
    req = OpenSSL::X509::Request.new
    req.version = 0
    req.subject = OpenSSL::X509::Name.new([
      ['C', @country, OpenSSL::ASN1::PRINTABLESTRING],
      ['ST', @state, OpenSSL::ASN1::UTF8STRING],
      ['L', @city, OpenSSL::ASN1::UTF8STRING],
      ['O', @organization, OpenSSL::ASN1::UTF8STRING],
      ['OU', @organizational_unit, OpenSSL::ASN1::UTF8STRING],
      ['CN', @common_name, OpenSSL::ASN1::UTF8STRING],
      ['emailAddress', @email, OpenSSL::ASN1::UTF8STRING]
    ])

    req.public_key = key.public_key
    req.sign(key, OpenSSL::Digest::SHA256.new)

    { csr: req.to_pem, key: key.to_pem }
  end

  # Method to write CSR to a file
  def write_csr_to_file(filename, csr_content)
    File.open(filename, 'w') do |file|
      file.write(csr_content)
    end
    puts "CSR written to #{filename}"
  end
end

# Example usage:
# csr_generator = CsrGenerator.new("example.com", "US", "California", "San Francisco", "Example Corp", "IT", "admin@example.com")
# result = csr_generator.generate_csr
# csr_generator.write_csr_to_file("example.csr", result[:csr])
# File.write("private_key.pem", result[:key])
