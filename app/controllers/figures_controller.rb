class FiguresController < ApplicationController
  # add controller methods

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index' 
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  post '/figures' do 
    @figure = Figure.create(params[:figure])
    if !params["landmark"]["name"].empty? || !params["title"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])

    # if !params[:figure].keys.include?("landmark_ids")
    #   params[:figure]["landmark_ids"] = []
    # end
    # if !params[:figure].keys.include?("title_ids")
    #   params[:figure]["title_ids"] = []
    # end
    
    if !params["landmark"]["name"].empty? || !params["title"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"])
      @figure.titles << Title.create(name: params["title"]["name"])
    end
    #@figure.save
    redirect "figures/#{@figure.id}"
  end

end
