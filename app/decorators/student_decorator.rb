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
end
