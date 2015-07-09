module ApplicationHelper

  def can_edit?(resource)
    true if current_instructor
    resource.respond_to?(:student) && resource.student == current_student
  end

  def react_time(time, opts = {})
    react_component('TimeField', { time: time }.merge(opts), tag: 'span')
  end

  def react_md(text, props = {}, opts = {})
    react_component('Markdown', { text: text }.merge(props), opts)
  end

  def markdown(source)
    Kramdown::Document.new(source).to_html.html_safe
  end

  def display_flash(key, msg)
    display_class = ((key == 'notice') ? 'success' : 'warning')
    content_tag :div, msg, class: "alert alert-#{display_class} flash #{key} alert-dismissible", role: "alert" do
      (content_tag :button, type: 'button', class: 'close', :'data-dismiss' => 'alert', :'aria-label' => 'Close' do
        content_tag :span, raw('&times;'), :'aria-hidden' => true
      end) + content_tag(:span, msg)
    end
  end

  def distance_from_current_cohort
    return unless current_student || current_instructor
    cohort = current_instructor.current_cohort if current_instructor
    cohort = current_student.cohort            if current_student
    return unless cohort
    "#{cohort.latitude},#{cohort.longitude}"
  end

  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?"
  end
end
