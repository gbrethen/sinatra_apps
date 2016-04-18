require 'sinatra'

get '/messages' do
	@msg_array = ["message1", "message2", "message3", "message4", "message5"]
	
	erb :message
end