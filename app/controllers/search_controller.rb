require "open-uri"
class SearchController < ApplicationController
  caches_action :index, :cache_path => Proc.new {
    |controller| controller.params}
 
  def index

    if params[:search] and params[:search] != "" then 
      params[:page] ||= 1
      @page = params[:page].to_i

      #@search = Entry.search_by_any(params[:search], params[:page], 30) 
      #@entries = @search

      results = EntrySearch.search params[:search], :ids => 30, :offset => (@page - 1) * 30

      if results[:total] == 0 then
        keizai = WadokuKeizai.search params[:search]
        flash[:notice] = t("search.nothing_found").html_safe
        unless keizai.empty? then
          flash[:notice] = t("wadokukeizai.result", :count => keizai.size, :link => keizai.search_link).html_safe
        end
        redirect_to search_path
      else
        results.extend Picky::Convenience
        @search_time = results[:duration]

        @total = results.total
        @total_pages = (@total / 30.0).ceil

        @next_page = @page == @total_pages ? "none" : @page + 1
        #@entries = results.ids.map{|id| Entry.find_by_wadoku_id(id)}.compact.uniq
        @entries = Entry.find_all_by_wadoku_id(results.ids.uniq)
        #@entries_left = @entries[0..@entries.size / 2]
        #@entries_right = @entries[(@entries.size / 2) + 1..-1]
        @entries_left, @entries_right = split_entries(@entries)
        respond_to do |format|
          format.html
          format.js
          format.json { if params[:full] == "true" then 
                          render :json  => {:total => results[:total], :from =>  ((@page - 1) * 30), :entries => @entries.map{|entry| {:daid => entry.wadoku_id, :midashigo => entry.writing, :kana => entry.kana, :german => entry.definition, :german_html => entry.full_html} }}
                        else
                          render :json => {:total => results[:total], :search_link => url_for(:action => :index, :search => params[:search])}
                        end
                      }

            format.xml  { render :xml => @entries }
          end
        end 
    else
      respond_to do |format|
        format.html{ render :start}
      end
    end
  end
  

  private

  def split_entries(entries)
    if entries.size == 1
      return [entries, []]
    else
      chars = entries.map{|e| e.full_html.size} 

      split_possible = (1...chars.size).map{|i|
        [i, (chars[0...i].inject(:+) - chars[i..-1].inject(:+)).abs]
      }

      index = split_possible.min_by{|e| e[1]}[0]
      
      [entries[0...index], entries[index..-1]]
    end
  end
  
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
