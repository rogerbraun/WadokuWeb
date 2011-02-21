class SearchController < ApplicationController
  def index
    redirect_to "search#start" unless params[:search]
    @search = Entry.search_by_any(params[:search])
    @entries = @search.paginate(:page => params[:page], :per_page => Entry.per_page)
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
