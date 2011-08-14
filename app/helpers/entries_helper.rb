module EntriesHelper

  def paginate(page, total, step = 30)
    "<b>#{total}</b>".html_safe
  end
end
