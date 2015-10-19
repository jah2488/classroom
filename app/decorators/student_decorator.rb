class StudentDecorator < Draper::Decorator
  delegate_all
  def avatar_url(size = 80)
    if object.user
      object.user.decorate.avatar_url(size)
    else
      "https://secure.gravatar.com/avatar/44e0021f61946ce33b0c965356f6ff99.png?r=PG&s=#{size}"
    end
  end

  def complete_percentage
    (object.complete_percentage * 100).round.to_s + "%"
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

  def phone
    object.user.decorate.phone if user
  end

  def email
    user.email if user
  end

  def pretty_name
    name || email || "Student ##{id}"
  end

  def info
    "tardies: #{tardies}\nabsences: #{absences}"
  end
end
