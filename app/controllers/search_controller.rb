class SearchController < ApplicationController
  def index
    @search = Entry.search(params[:search])
    @entries = @search.paginate(:page => params[:page], :per_page => Entry.per_page)
    respond_to do |format|
      format.html
    end 
  end

  def start
    @search = Entry.search(params[:search])
    respond_to do |format|
      format.html
    end
  end

end
