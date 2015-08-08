class InstructorDecorator < Draper::Decorator
  delegate_all
  def avatar_url(size = 80)
    if object.user
      object.user.decorate.avatar_url(size)
    else
      "https://secure.gravatar.com/avatar/44e0021f61946ce33b0c965356f6ff99.png?r=PG&s=#{size}"
    end
  end
end
