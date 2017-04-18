module ApplicationHelper
  def date(object)
    if object.event
      object.event.date
    else
      "HAASTE"
    end
  end


end
