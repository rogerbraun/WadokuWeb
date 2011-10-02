require "open-uri"
class SearchController < ApplicationController
  def index
    redirect_to "search#start" unless params[:search]

    params[:page] ||= 1
    @page = params[:page].to_i
    #@search = Entry.search_by_any(params[:search], params[:page], 30) 
    #@entries = @search

    results = EntrySearch.search params[:search], :ids => 30, :offset => (@page - 1) * 30

    if results[:total] == 0 then
      keizai = WadokuKeizai.search params[:search]
      flash[:notice] = t("search.nothing_found").html_safe
      unless keizai.empty? then
        flash[:notice] += " WadokuKeizai hat aber #{keizai.size} Ergebnisse.".html_safe
        flash[:notice] += " <br><h3><a href='#{keizai.search_link}'>Auf WadokuKeizai.de suchen</a></h3>".html_safe
      end
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

  private

  
  class WadokuKeizai

    URL = "http://wadokukeizai.de/api/"
    KEY = "wadoku.eu"

    def self.search(keyword, mode = nil) 

      url = URL + "?key=#{KEY}" + "&q=#{CGI::escape(keyword)}"

      data = ::Yajl::Parser.new.parse(open(url).read)
 

      Results.new(data, keyword)

    end

    class Results

      attr_reader :direct_results, :indirect_results, :indirect_link, :direct_link

      def initialize(data, q)
        
        temp = data["wadokukeizai"].first

        @q = q
        @direct_results = temp["direct_results"].to_i
        @indirect_results = temp["indirect_results"].to_i
        @direct_link = temp["direct_link"]
        @indirect_link = temp["indirect_link"]

      end

      def empty?
        size == 0 
      end
    
      def size 
        @direct_results + @indirect_results
      end

      def search_link
        "http://wadokukeizai.de/suchen/" + CGI::escape(@q)
      end
    
    end
  end
end
