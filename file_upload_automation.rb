require 'net/ssh'
require 'net/scp'

def get_file_list(path)  
  Dir.entries(path).each do |sub|
    Dir::chdir(path)
    if sub != '.' && sub != '..'  
      if File.directory?("#{path}/#{sub}")    
        get_file_list("#{path}/#{sub}")  
      else
        Net::SSH.start('10.48.192.16', 'app03', :password => 'handpay', :port => 10051) do |ssh|
          res = ssh.exec! "ls /opt/app03/test/|grep #{sub}"
          begin 
            res = res.strip
          rescue Exception
          end
          if sub == res
            puts "#{sub} exists."
            ssh.exec! "rm -f /opt/app03/test/#{sub}"
            Net::SCP.start('10.48.192.16', 'app03', :password => 'handpay', :port => 10051) do |scp|
              scp.upload! sub, '/opt/app03/test' do |ch, name, sent, total|
                print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
              end
              print "\n"
            end
          else
            puts "#{sub} doesn't exists"
          end
        end
      end  
    end  
  end  
end

get_file_list("E:/lib/test")
