#!/usr/bin/env ruby

require 'keystores'
require 'openssl'

KEYSTORE=''
PASSWORD=''

keystore = OpenSSL::JKS.new
md5 = OpenSSL::Digest::MD5.new
p12 = OpenSSL::PKCS12.new
keystore.load(KEYSTORE, PASSWORD)
cert = OpenSSL::X509::Certificate.new(keystore.get_certificate('js_encryption1'))

issuer = cert.issuer
subject = cert.subject
serialnumber = cert.serial
extensions = cert.extensions
key_usage = nil

extensions.each do |e|
  if e.to_s =~ /keyUsage/
    key_usage = e.to_s.gsub!(/keyUsage\s+=\s+/,'')
  end
end

puts issuer
puts subject
puts key_usage
puts cert.not_after
puts OpenSSL::Digest::MD5.hexdigest(cert.to_der).upcase.scan(/.{2}/).join(':')
