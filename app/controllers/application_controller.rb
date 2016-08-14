# require './config/environment'

class ApplicationController < Sinatra::Base


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
    #unknown attribute 'submit' for Recipe...? Resolved w/ "use Rack::MethodOverride"
  end

  post '/recipes' do
    #binding.pry
    @recipe = Recipe.create(params)#(:title => params[:title], :content => params[:content])
    #binding.pry
    redirect to "/recipes/#{@recipe.id}"
  end

  # params => {"name"=>"pumpkin pie", "ingredients"=>"pumpkin, flour, butter, sugar", "cook_time"=>"1 hour"}
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id/delete' do
    #binding.pry
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    #Recipe.find(params[:id]).destroy
    #@recipes = Recipe.all

    redirect to '/recipes'

    #erb :index
  end

end
