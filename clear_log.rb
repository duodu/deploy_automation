require 'net/ssh'
require File.expand_path('../config.rb', __FILE__)

$instance.each do |instance|
  Net::SSH.start(instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port]) do |ssh|
    ssh.exec! "echo > /opt/#{instance[:username]}/server/default/log/server.log"
    puts "#{instance[:ip]} " + "#{instance[:username]} " + "'s log has been cleared"
  end
end