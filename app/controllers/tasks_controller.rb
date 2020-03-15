class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :edit, :destroy]
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  
  
  def index
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc)
    end
  end

  def show
    
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'タスクが正常に追加されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'タスクが追加されませんでした'
      render :new
    end
  end

  def edit
  end
  
  def update
      if @task.update(task_params)
        flash[:success] = 'タスクは正常に追加されました'
        redirect_to @task
      else
        flash[:danger] = 'タスクは追加できませんでした'
        render :edit
      end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to tasks_path
  end
  
  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
end
