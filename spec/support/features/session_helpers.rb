module Features
  module SessionHelpers
    def sign_in(type)
      case type
      when :instructor
        visit new_user_session_path
        fill_in 'Email', with: 'instructor@theironyard.com'
        fill_in 'Password', with: 'password'
        click_button 'Log in'
        expect(page).to have_content('Signed in successfully')
      else
        raise 'Sign in type not found. Please add a new entry for that type.'
      end
    end
  end
end
