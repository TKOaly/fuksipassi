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

  def point_badge(points)
    if points > 9
      'very-positive-score badge badge-pill'
    elsif points <0
      'negative-score badge badge-pill'
    else
      'positive-score badge badge-pill'
    end
  end

  def glyph(*names)
    content_tag :i, nil, :class => names.map{|name| "glyphicon glyphicon-#{name.to_s.gsub('_','-')}" }
  end

  def admin?
    current_user&.has_role? 'admin'
  end

  def fuksi?
    current_user&.has_role? 'fuksi'
  end


end
