require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

   	post "/posts" do
	  	#use Create CRUD action to create blog post and save to database
	  	#use erb to render indes view page
	  	@new_post = Post.create(name: params[:post][:name], content: params[:post][:content])
	  	@posts = Post.all
	  	erb :index
	end

	get '/posts' do 
  		@posts = Post.all
    	erb :index
 	end

 	get '/' do
  		redirect '/posts'
  	end


	get '/posts/new' do
		#renders new.erb view
		erb :new
  	end	

	get '/posts/:id' do
  		@post = Post.find(params[:id])
  		erb :show
  	end

	get '/posts/:id/edit' do
		@id = params[:id]
		@post = Post.find(params[:id])
		erb :edit
	end

	patch '/posts/:id' do
		Post.update(params[:id], :name => params[:post][:name], :content => params[:post][:content])
		redirect '/posts/' + params[:id]
	end

	delete '/posts/:id/delete' do 
		@deleted_post = Post.find(params[:id])
    	Post.destroy(params[:id])
    	erb :deleted

	end





end