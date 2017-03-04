require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'
  
  ### using shotgun instead of sinatra/reloader for now ###
  #configure :development do   #runtime reloading support
  #  register Sinatra::Reloader
  #end
  not_found do #error processing when something is not found
    erb :error
  end
  
  get '/' do #main page
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}
  end
  
  get '/edit/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end
  
  post '/' do    
    IdeaStore.create(params[:idea])
    redirect '/'
  end
  
  #TODO: fix rank system
  post '/like/:id' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end
  
  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end
  
  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end
end