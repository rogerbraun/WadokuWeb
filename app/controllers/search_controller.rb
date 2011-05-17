class SearchController < ApplicationController


  def index
    redirect_to "search#start" unless params[:search]
    unless read_fragment({:page => params[:page] || 1, :search => params[:search]})
      params[:search].to_kana!
      @entries = Entry.search_by_any(params[:search], params[:page], 30) 
    end
    
    respond_to do |format|
      format.html
      format.js
    end 
  end

  def start
    @search = Entry.search(params[:search])
    respond_to do |format|
      format.html
    end
  end

end
