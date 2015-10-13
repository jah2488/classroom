class CohortDecorator < Draper::Decorator
  delegate_all
  decorates_association :current_day
  decorates_association :instructors

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
      "39474e"
    end
  end

  def dark_color
    darken_color(color, 0.7)
  end

  def logo_url
    if data_science?
      h.image_url "data-science-icon.png"
    elsif frontend?
      h.image_url "front-end-engineering-icon.png"
    elsif mobile?
      h.image_url "mobile-engineering-icon.png"
    elsif backend?
      h.image_url "back-end-engineering-icon.png"
    end
  end

  def sign_up_url
    h.new_user_registration_url(cohort_id: cohort.id)
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
