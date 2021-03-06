#!/usr/bin/env ruby
# encoding: ASCII-8BIT
require 'AddDriver.rb'

endpoint_url = ARGV.shift
value = ARGV.shift
if ((endpoint_url == nil) or (value == nil)) then
  puts "Usage: ${0} <service-url> <value>"
  exit -1
end

obj = AddPortType.new(endpoint_url)
# run ruby with -d to see SOAP wiredumps.
obj.wiredump_dev = STDERR if $DEBUG


begin
  request = Add.new(value)
  response = obj.add(request)
  puts "Result: #{response.sum}"
rescue SOAP::FaultError => e
  puts "Fault caught! Reason: '#{e.detail.addFault.reason}' Severity: '#{e.detail.addFault.severity}'"
end


