class StudentDecorator < Draper::Decorator
  delegate_all
  def avatar_url
    if object.user
      object.user.decorate.avatar_url
    else
      ""
    end
  end

  def github
    object.user.decorate.github if user
  end

  def blog_link
    h.link_to h.truncate(object.blog, length: 23), object.blog.to_s
  end

  def name
    object.user.decorate.name if user
  end

  def email
    user.email if user
  end

  def pretty_name
    name || email || "Student ##{id}"
  end
  def info
    "#{pretty_name} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
