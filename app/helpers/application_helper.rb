module ApplicationHelper
  def display_flash(key, msg)
    display_class = key == 'notice' ? 'success' : 'warning'
    content_tag :div, msg, class: "alert alert-#{display_class} flash #{key} alert-dismissible", role: "alert" do
      (content_tag :button, type: 'button', class: 'close', :'data-dismiss' => 'alert', :'aria-label' => 'Close' do
        content_tag :span, raw('&times;'), :'aria-hidden' => true
      end) + content_tag(:span, msg)
    end
  end
end
