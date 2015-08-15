class CohortDecorator < Draper::Decorator
  delegate_all
  decorates_association :current_day
  decorates_association :instructor

  def color
    if data_science?
      "55BA79"
    elsif frontend?
      "CF852C"
    elsif mobile?
      "d5b810"
    elsif backend?
      "AF5C56"
    else
      "00B5A4"
    end
  end

  def dark_color
    darken_color(color, 0.7)
  end

  def logo_url
    if data_science?
      "http://theironyard.com/images/courses/icons/data-science-icon.png"
    elsif frontend?
      "http://theironyard.com/images/courses/icons/front-end-engineering-icon.png"
    elsif mobile?
      "http://theironyard.com/images/courses/icons/mobile-engineering-icon.png"
    elsif backend?
      "http://theironyard.com/images/courses/icons/back-end-engineering-icon.png"
    end
  end

  def sign_up_url
    h.new_user_registration_path(cohort_id: cohort.id)
  end

  def mobile?
    object.name.match(/mobile/i)
  end

  def frontend?
    object.name.match(/front\s*end/i)
  end

  def backend?
    object.name.match(/(rails|back\s*end)/i)
  end

  def data_science?
    object.name.match(/data/i)
  end

  private

  def darken_color(hex_color, amount=0.4)
    hex_color = hex_color.gsub('#','')
    rgb = hex_color.scan(/../).map(&:hex).map{|color| color * amount}.map(&:round)
    "%02x%02x%02x" % rgb
  end
end
