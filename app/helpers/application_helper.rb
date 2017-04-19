module ApplicationHelper
  def date(object)
    if object.is_a? Event
      object.date
    elsif object.event
      object.event.date
    else
      "HAASTE"
    end
  end


end
