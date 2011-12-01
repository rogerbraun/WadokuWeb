require "open-uri"
class SearchController < ApplicationController
  caches_action :index, :cache_path => Proc.new {
    |controller| controller.params}
 
  def index

    if params[:search] and params[:search] != "" then 
      params[:page] ||= 1
      @page = params[:page].to_i

      @total, @entries = EntryDecorator.search_with_picky params[:search], :ids => 30, :offset => (@page - 1) * 30
      @total_pages = (@total / 30.0).ceil

      if @total == 0 then
        search_at_keizai
      else
        @next_page = @page == @total_pages ? "none" : @page +1
        @entries_left, @entries_right = split_entries(@entries)

        respond_to do |format|
          format.html
          format.js
          format.json {
            if params[:full] == "true" then 
              render :json  => {:total => @total, :from =>  ((@page - 1) * 30), :entries => @entries.map{|entry| {:daid => entry.wadoku_id, :midashigo => entry.writing, :kana => entry.kana, :german => entry.definition, :german_html => entry.full_html} }}
            elsif params[:simple]
              simple_json  
            else
              render :json => {:total => @total , :search_link => url_for(:action => :index, :search => params[:search])}
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


  def headwords
    max = params.delete(:max) || 10
    q = params.delete(:search) || ""
    @headwords = Entry.search_for_headwords(q, max)
    respond_to do |f|
      f.json { render :json => @headwords, :callback => params[:callback]}
    end
  end

  def tres
    max = params.delete(:max) || 10
    q = params.delete(:search) || ""
    @tres = Entry.search_for_tres(q, max)
    respond_to do |f|
      f.json { render :json => @tres, :callback => params[:callback]}
    end
  end

  
  private

  def simple_json 
    #render :json  => {:total => @total, :from =>  ((@page - 1) * 30), :entries => @entries.map{|entry| {:daid => entry.wadoku_id, :midashigo => entry.writing, :kana => entry.kana, :german => entry.definition, :german_html => entry.full_html} }}, :callback => params[:callback]
    data = {
      total:  @total,
      from:   ((@page - 1) * 30),
      entries: @entries.map(&:simple)
    }
    render :json => data, :callback => params[:callback]
  end

  def search_at_keizai
    keizai = WadokuKeizai.search params[:search]
    flash[:notice] = t("search.nothing_found").html_safe
    unless keizai.empty? then
      flash[:notice] = t("wadokukeizai.result", :count => keizai.size, :link => keizai.search_link).html_safe
    end
    redirect_to search_path
  end

  def split_entries(entries)
    if entries.size == 1
      return [entries, []]
    else
      chars = entries.map{|e| e.text_size} 

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
