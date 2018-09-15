class GoalsController < ApplicationController
  def index
    @goals = Goal.all
    render :index
  end
  
  def new
    @goal = Goal.new
    render :new
  end
  
  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash[:errors] = "Wrong username or password"
      render new_session_url
    end
  end
  
  def destroy
    @goal = Goal.find(params[:id])
    
    if @goal.delete
      redirect_to goals_url
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to goals_url  
    end
  end
  
  private
  
  def goal_params
    params.require(:goal).permit(:title, :user_id, :state)
  end
end