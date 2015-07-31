class StudentDecorator < Draper::Decorator
  delegate_all

  def avatar_url
    if object.user
      object.user.avatar_url
    else
      ""
    end
  end

  def github
    if object.user
      object.user.github
    end
  end

  def name
    user.name if user
  end

  def email
    user.email if user
  end

  def info
    "#{(name || email)} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
