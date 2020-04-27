require 'gossip'
class ApplicationController < Sinatra::Base

	get '/' do
		erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
 	 Gossip.new(params["gossip_author"], params["gossip_content"]).save
 	 redirect '/'
	end

	get '/gossip/:id' do
  	erb :gossip_profile
	end

	get '/edit/:id' do 
		erb :edit
	end

	post '/gossip/edit/:id' do
		Gossip.modify(Gossip.find(params[:id]).content, params["gossip_new_content"])
		redirect '/'
	end
end