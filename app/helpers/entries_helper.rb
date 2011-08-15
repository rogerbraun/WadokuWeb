module EntriesHelper

  def paginate(page, total, step = 30)
    pages = (total / step.to_f).ceil
    ( "<nav class='pagination'>" + 
      1.upto(pages).map{|n| "<span class='page#{ page == n ? ' current' : ""}'>#{link_to(n.to_s, search_index_path(:page => n, :search => params[:search]))}</span>"}.join("") +
      "</nav>"
    ).html_safe
  end
end
