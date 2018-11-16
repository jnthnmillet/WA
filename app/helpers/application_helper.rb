module ApplicationHelper
  def format_date(date)
    Time.parse(date).strftime('%b %d, %Y')
  end
end
