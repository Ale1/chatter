require 'socket'
require 'thread'



# krazy-talk feature

krazy_words = {bye: 'See you later alligator!', hello: 'Howda-doodah!', thanks:'Revenge will be mine!' }                   
KJ_NOUNS =['Peanut butter','Strawberries','Dog','Flowers','Car','Hair','Breakfast','house','girlfriend','boyfriend','ex','school','cat','favorite ninja turtle','worst enemy','best friend','job','lunch','plans','dreams','hopes','fears','eyeballs','pegleg','trousers']
KJ_VERBS = ['ate','ruined', 'built','recited poetry to', 'muddled','smooth-talked','seduced','angered','phoned','improved','threw away','confused','milked','made pretty','touched','licked','completed','chopped','ordered','painted','vomited on','spat on','']
KJ_POS =['his','your']
#initialize section

@server = TCPServer.new 'localhost',9999
@messages, @all_clients, @log = [],[],[]




def listen
# accepting clients and taking messages 


  Thread.start(@server.accept) do |client| 
    @all_clients << client  #when client connects, adds to list of active users
    @handle = client.gets.chomp 
    p "accepted #{client}"
    

    loop do 
     input = client.gets.chomp 
      msg = [@handle, input]
      p "just handled message"
      p "just printed message"
      @messages << msg
      p  "stored message"
      close_connection(client) if input.downcase == "quit"
    end

  end
end

def broadcast
#message broadcast system
  Thread.start do
    p "I'm in the broadcast thread"
    loop do 
      if  @messages.count > 0 
      msg = @messages.shift # takes out oldest message
      p "just popped #{msg}"
      @all_clients.each { |client| client.puts "#{msg.first} >> #{msg.last} "} #and sends to all
      @log << msg  #stores old messages in log 
      end
    end
  end
end

def close_connection(client,ban=false)
p "#{client.handle} is being a butthole and has been banned" if ban==true
p "#{client.handle} has disconnected"
client.close
end

def ban_user(client)
p 
end
####################################

 #loop over accepting clients, taking messages & broadcasting
def run
  listen
  broadcast
  loop do
    sleep(10)
    @all_clients.each {|client| client.puts "Krazy Joe #{KJ_VERBS.sample} #{KJ_POS.sample} #{KJ_NOUNS.sample}!"} 
  end
end

run


