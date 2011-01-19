module ApplicationHelper
  def current_url(overwrite={})
    url_for :only_path => false, :params => params.merge(overwrite)
  end


end
