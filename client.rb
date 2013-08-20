require 'socket'
require 'thread'



# krazy-talk feature
krazy_database ={}

#initialize section

server = TCPServer.new 'localhost',9999
messages,all_clients,log = [],[],[]


loop do

# accepting clients and taking messages 
  Thread.start(server.accept) do |client| 
    all_clients << client  #when client connects, adds to list of active users
    while msg = [client, client.gets] && !input.last.empty?  #receives client messages
      messages << input   #and stores to the message repo
    end
  end

#message broadcast system
  Thread.start do
    while !messages.empty? 
      msg = messages.shift # takes out oldest message
      all_clients.each { |client| client.puts "#{msg.first}>>'#{msg.last}'"} #and sends to all
      log << msg  #stores old messages in log 
    end
  end


end



