require 'net/ssh'
require 'net/scp'
require 'timeout'
Dir::chdir('E:/lib/test')

Net::SCP.start('10.48.192.16', 'app03', :password => 'handpay', :port => 10051) do |scp|
  #puts instance[:ip] + instance[:username] + ' will restart at once'
  scp.upload! 'test1.txt', '/opt/app03/test' do |ch, name, sent, total|
    print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
  end
  puts "done"
end