module ApplicationHelper
  def formatted_date(date)
    if date
      date.strftime("%B %d, %Y")
    end
  end
end
