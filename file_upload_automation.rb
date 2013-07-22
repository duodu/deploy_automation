require 'net/ssh'
require 'net/scp'
require File.expand_path('../upload_config.rb', __FILE__)

def get_file_list(path)  
  Dir.entries(path).each do |sub|
    Dir::chdir(path)
    if sub != '.' && sub != '..'  
      if File.directory?("#{path}/#{sub}")
        get_file_list("#{path}/#{sub}")
      else
        $instance.each do |instance|
          Net::SSH.start( instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port] ) do |ssh|
            instance[:dir].each do |dir|
              res = ssh.exec! "ls #{dir}|grep #{sub}"
              begin
                res = res.strip
              rescue Exception
              end
              if res == sub
                puts "#{instance[:ip]}: There is #{sub} in #{dir}."
                ssh.exec! "rm -f #{dir}#{sub}"
                Net::SCP.start( instance[:ip], instance[:username], :password => instance[:password], :port => instance[:port] ) do |scp|
                  scp.upload! sub, dir do |ch, name, sent, total|
                    print "\r#{name}: #{(sent.to_f * 100 / total.to_f).to_i}%"
                  end
                  print "\n"
                  puts "=============Success====================="
                  puts "#{instance[:ip]}: #{sub} is uploaded to #{dir}."
                  puts "========================================="
                end
              else
                puts "===============Warning====================="
                puts "#{instance[:ip]}: #{dir} have no #{sub}!"
                puts "==========================================="
              end
            end
          end
        end
      end  
    end  
  end  
end

get_file_list($deploy_dir)
