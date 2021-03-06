class TasksController < ApplicationController
  load_and_authorize_resource
  before_action :set_task, only: %i[ show edit update destroy, trigger]    

  # rescue_from ActiveRecord::RecordNotUnique do |exception|
  #   flash[:alert] = "participants cant be repeated in the same task"
  #   redirect_to new_task_path
  # end

  # GET /tasks or /tasks.json
  def index
    @tasks = (current_user.own_tasks + current_user.commitments).uniq
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.owner = current_user    

    if task_params[:participants_attributes].nil?
      a = [0]
    else
      a = task_params[:participants_attributes].values.collect{|value| value["user_id"]}     
    end
    
    
    if a == a.uniq       
      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: "Task was successfully created." }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "participants cant be repeated in the same task"
      redirect_to new_task_path
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update    
    if task_params[:participants_attributes].nil?
      a = [0]
    else
      a = task_params[:participants_attributes].values.collect{|value| value["user_id"]}     
    end       
    
    if a == a.uniq       
      respond_to do |format|            
        if @task.update(task_params)
          format.html { redirect_to @task, notice: "Task was successfully updated." }
          format.json { render :show, status: :ok, location: @task }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    else
      flash[:alert] = "participants cant be repeated in the same task"
      redirect_to new_task_path
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def trigger
    Tasks::TriggerEvent.new.call @task, params[:event]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(
        :name, 
        :description, 
        :due_date, 
        :category_id,
        participants_attributes: [
          :user_id,          
          :role,
          :id,
          :event,
          :_destroy
        ]
      )
    end
end
