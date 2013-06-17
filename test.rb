require 'net/ssh'
require 'net/scp'
require 'timeout'

Net::SSH.start('10.48.192.16', 'app02', :password => 'handpay', :port => 10051) do |ssh|
  #puts instance[:ip] + instance[:username] + ' will restart at once'
  begin
  Timeout.timeout(2) {
        ssh.exec! "sh /opt/app02/bin/hp restart"
      }
  rescue Exception
  end
  puts "done"
end