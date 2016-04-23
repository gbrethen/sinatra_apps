get '/people' do
	@people = Person.all
	erb :"/people/index"
end

post '/people' do
	if params[:birthdate] != ''
		if params[:birthdate].include?("-") || params[:birthdate].include?("/")
			birthdate = Date.strptime(params[:birthdate].gsub("/",""), "%m%d%Y")
		else
			birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
		end
	else
		birthdate = ''
	end
	
	@person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
	if @person.valid?
		@person.save
		redirect "/people/#{@person.id}"
	else
		@error = ''
		@person.errors.full_messages.each do |message| # retrieve the error message from the @person valid method
			@error = "#{@errors} #{message}"
		end
		@heading = "Add new person"
		erb :"/people/new"
	end
	
end

get '/new' do
	@heading = "Add new person"
	@person = Person.new
	@birthdate = ''
	erb :"/people/new"
end

get '/people/:id' do
	@person = Person.find(params[:id])
	birthdate_string = @person.birthdate.strftime("%m%d%Y")
	@birth_path_num = Person.get_birth_path_num(birthdate_string)
	@message = Person.get_message(@birth_path_num)
	erb :"/people/show"
end

get '/people/:id/edit' do
	@person = Person.find(params[:id])
	@birthdate = @person.birthdate.strftime("%m/%d/%Y")
	@heading = "Edit person"
	erb :"/people/edit"
end

put '/people/:id' do
	@person = Person.find(params[:id])
	@person.first_name = params[:first_name]
	@person.last_name = params[:last_name]
	
	if params[:birthdate] != ''
		if params[:birthdate].include?("-") || params[:birthdate].include?("/")
			birthdate = Date.strptime(params[:birthdate].gsub("/",""), "%m%d%Y")
		else
			birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
		end
	else
		birthdate = ''
	end
	
	@person.birthdate = birthdate
	
	if @person.valid?
		@person.save
		redirect "/people/#{@person.id}"
	else
		@error = ''
		@person.errors.full_messages.each do |message| # retrieve the error message from the @person valid method
			@error = "#{@errors} #{message}"
		end
		@heading = "Edit person"
		erb :"/people/edit"
	end
	
		
	
end

delete '/people/:id' do
	person = Person.find(params[:id])
	person.destroy
	redirect "/people"
end



