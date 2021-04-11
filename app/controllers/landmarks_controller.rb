class LandmarksController < ApplicationController
  # add controller methods

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index' 
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  post '/landmarks' do 
    @landmark = Landmark.create(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.create(name: params["figure"]["name"])
    end
    @landmark.save
    redirect to "landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do 
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do 
    @landmark = Landmark.find_by_id(params[:id])
    @landmark.update(params[:landmark])
    if !params["figure"]["name"].empty?
      @landmark.figure = Figure.create(name: params["figure"]["name"])
    end
    @landmark.save
    redirect to "landmarks/#{@landmark.id}"
  end

end
