module ApplicationHelper

  def react_time(time, opts = {})
    react_component('TimeField', { time: time, hoverable: true }.merge(opts), tag: 'span')
  end

  def react_md(text, props = {}, opts = {})
    react_component('Markdown', { text: text }.merge(props), opts)
  end

  def markdown(source)
    Kramdown::Document.new(source || '').to_html.html_safe
  end

  def form_errors_for(object=nil)
    render('application/form_errors', object: object) unless object.blank?
  end

  def display_flash(key, msg)
    display_class = ((key == 'notice') ? 'success' : 'warning')
    content_tag :div, msg, class: "alert alert-#{display_class} flash #{key} alert-dismissible", role: "alert" do
      (content_tag :button, type: 'button', class: 'close', :'data-dismiss' => 'alert', :'aria-label' => 'Close' do
        content_tag :span, raw('&times;'), :'aria-hidden' => true
      end) + content_tag(:span, msg)
    end
  end

  def distance_from_cohort cohort
    return unless cohort
    "#{cohort.campus.latitude},#{cohort.campus.longitude}"
  end

  def menu_items user
    links = []
    if user
      if user.student?
        links << active_link_to('My Cohort', root_path)
        links << active_link_to('Profile', student_path(user.student))
      elsif current_user.instructor?
        links << active_link_to('Dashboard', staff_root_path)
        links << active_link_to("Cohorts", staff_cohorts_path)
        links << active_link_to("Campuses", staff_campuses_path)
        links << active_link_to("Students", students_path)
      end
    end
    if user
      links << active_link_to('Logout', destroy_user_session_path)
    else
      links << active_link_to('Signin', new_user_session_path)
    end
    links.map { |l| "<li>" + l + "</li>"}.join('').html_safe
  end
end
