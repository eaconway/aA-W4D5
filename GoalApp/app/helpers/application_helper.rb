module ApplicationHelper
  def auth_token
    "<input type='hidden' 
    name='authenticity_token' 
    value='#{form_authenticity_token}'>".html_safe
  end
  
  def logout
    "<form action='#{session_url}' method='post'>
      #{auth_token}
      <input type='hidden' name='_method' value='delete'>
      <input type='submit' name='submit' value='Logout'>
    </form>".html_safe
  end
  
  def delete_user(user)
    "<form action='#{user_url(user)}' method='post'>
      #{auth_token}
      <input type='hidden' name='_method' value='delete'>
      <input type='submit' name='submit' value='Delete User'>
    </form>".html_safe
  end
  
  def delete_goal(goal)
    "<form action='#{goal_url(goal)}' method='post'>
      #{auth_token}
      <input type='hidden' name='_method' value='delete'>
      <input type='submit' name='submit' value='Delete Goal'>
    </form>".html_safe
  end
  
end
