require 'openssl'
require 'json'
require 'base64'

# rubocop:disable MethodLength, Metrics/AbcSize

class Utils < Thor
  class_option :fields, default: 'CN=localhost'

  desc 'create_key', 'create a RSA 2048 key'
  option :keyfile, default: 'logstash.key'
  def create_key
    key = OpenSSL::PKey::RSA.new 2048
    open options[:keyfile], 'w' do |io|
      io.write key.to_pem
    end
    puts "wrote #{options[:keyfile]}"
  end

  desc 'create_cert', 'create a certificate with a key'
  option :keyfile, default: 'logstash.key'
  option :crtfile, default: 'logstash.crt'
  def create_cert
    key = OpenSSL::PKey::RSA.new File.read options[:keyfile]
    cert = OpenSSL::X509::Certificate.new
    cert.subject = cert.issuer = OpenSSL::X509::Name.parse options[:fields]
    cert.version = 2
    cert.serial = 0
    cert.not_before = Time.now
    cert.not_after = Time.now + 3.15569e8
    cert.public_key = key.public_key
    ext = OpenSSL::X509::ExtensionFactory.new
    ext.subject_certificate = cert
    ext.issuer_certificate = cert
    cert.extensions = [
      ext.create_extension('basicConstraints', 'CA:TRUE', true),
      ext.create_extension('subjectKeyIdentifier', 'hash'),
      ext.create_extension('keyUsage', 'cRLSign,keyCertSign', true)
    ]
    cert.sign key, OpenSSL::Digest::SHA256.new
    open options[:crtfile], 'w' do |io|
      io.write cert.to_pem
    end
    puts "wrote #{options[:crtfile]} with #{options[:keyfile]} using #{options[:fields]}"
  end

  desc 'create_bag', 'create a Chef data bag of cert and key'
  option :keyfile, default: 'logstash.key'
  option :crtfile, default: 'logstash.crt'
  option :bagfile, default: 'logstash.json'
  def create_bag
    key = Base64.encode64 File.read options[:keyfile]
    crt = Base64.encode64 File.read options[:crtfile]
    bag = {
      id: 'logstash',
      certificate: crt,
      key: key
    }
    open options[:bagfile], 'w' do |io|
      io.write JSON.pretty_generate(bag)
    end
    puts "wrote #{options[:bagfile]} with base64 contents of #{options[:keyfile]} and #{options[:crtfile]}"
  end

  desc 'quick_bag', 'executes create_cert, create_key & create_bag with defaults'
  option :keyfile, default: 'logstash.key'
  option :crtfile, default: 'logstash.crt'
  option :bagfile, default: 'logstash.json'
  def quick_bag
    create_key
    create_cert
    create_bag
  end
end
