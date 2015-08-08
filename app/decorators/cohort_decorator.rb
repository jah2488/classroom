class CohortDecorator < Draper::Decorator
  delegate_all
  decorates_association :current_day
  decorates_association :instructor

  def color
    if object.name.match(/data/i)
      "55BA79"
    elsif object.name.match(/frontend/i)
      "CF852C"
    elsif object.name.match(/mobile/i)
      "d5b810"
    else
      "AF5C56"
    end
  end

  def dark_color
    darken_color(color, 0.7)
  end

  def logo_url
    if object.name.match(/data/i)
      "http://theironyard.com/images/courses/icons/data-science-icon.png"
    elsif object.name.match(/frontend/i)
      "http://theironyard.com/images/courses/icons/front-end-engineering-icon.png"
    elsif object.name.match(/mobile/i)
      "http://theironyard.com/images/courses/icons/mobile-engineering-icon.png"
    else
      "http://theironyard.com/images/courses/icons/back-end-engineering-icon.png"
    end
  end

  def sign_up_url
    h.url_for(only_path: false, controller: '/registrations', action: :new, cohort_id: cohort.id)
  end

  private

  def darken_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map(&:hex).map{|color| color * amount}.map(&:round)
    "%02x%02x%02x" % rgb
  end
end
