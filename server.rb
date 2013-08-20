require 'socket'
require 'thread'



# krazy-talk feature

krazy_words = {bye: 'See you later alligator!', hello: 'Howda-doodah!', thanks:'Revenge will be mine!' }                   

#initialize section

@server = TCPServer.new 'localhost',9999
@messages,@all_clients,log = [],[],[]




def listen
# accepting clients and taking messages 
  Thread.start(@server.accept) do |client| 
    p "I'm in the listen thread"

    @all_clients << client  #when client connects, adds to list of active users
    p client.gets
    while msg = [client.handle, client.gets] && msg.last != ""
      p msg.last
      @messages << msg

    end

  end
end

def broadcast
#message broadcast system
  Thread.start do
    p "I'm in the broadcast thread"
    while !@messages.empty? 
      msg = @messages.shift # takes out oldest message
      @all_clients.each { |client| client.puts "#{msg.first}>>'#{msg.last}'"} #and sends to all
      @log << msg  #stores old messages in log 
    end
  end
end

####################################


loop do #loop over accepting clients, taking messages & broadcasting
  listen
  broadcast

end
