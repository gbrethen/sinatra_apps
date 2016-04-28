get '/words' do
	@words = Word.all
	erb :"/words/index"
end

get '/words/:id' do
	@word = Word.find(params[:id])
	erb :"/words/show"
end

get '/new' do
	@heading = "Add new word"
	@label = "Enter a new word:"
	@word = Word.new
	erb :"/words/new"
end

get '/words/:id/edit' do
	@heading = "Edit word"
	@label = "Edit the word:"
	@word = Word.find(params[:id])
	erb :"/words/edit"
end

post '/words' do
	word = Word.create(text: params[:word])
	redirect "/words/#{word.id}"
end

put '/words/:id' do
	@word = Word.find(params[:id])
	@word.text = params[:word]
	@word.save
	erb :"/words/show"
end

delete '/words/:id' do
	word = Word.find(params[:id])
	word.destroy
	redirect "/words"
end