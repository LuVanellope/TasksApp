class TasksController < ApplicationController

  before_action :authenticate_user!
  before_action :find_user
  before_action :check_user, only: [:index, :show]

  def index
    @tasks = @user.tasks
  end

  def show
    @task = @user.friendly.tasks.find(params[:id])
  end

  def new
    @task = @user.tasks.new
  end

  def create
    @task = @user.tasks.create(tasks_params)

    if @task.save
      redirect_to action: 'index'
    else
      render :new
    end
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def check_user
    if current_user != User.find(params[:user_id])
      redirect_to root_path
    end
  end

  def tasks_params
    params.require(:task).permit(:tilte, :description)
  end
end
