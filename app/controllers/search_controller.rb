class SearchController < ApplicationController
  def index
    redirect_to "search#start" unless params[:search]

    params[:page] ||= 1
    @page = params[:page].to_i
    #@search = Entry.search_by_any(params[:search], params[:page], 30) 
    #@entries = @search

    results = EntrySearch.search params[:search], :ids => 30, :offset => (@page - 1) * 30

    if results.empty? then
      flash[:notice] = t("search.nothing_found")
      redirect_to search_path
    else
      results.extend Picky::Convenience
      @search_time = results[:duration]

      @total = results.total
      @entries = results.ids.map{|id| Entry.find_by_wadoku_id(id)}.compact
      respond_to do |format|
        format.html
        format.js
        format.xml  { render :xml => @entries }
      end 
    end
  end

  def start
    @search = Entry.search(params[:search])
    respond_to do |format|
      format.html
    end
  end

end
