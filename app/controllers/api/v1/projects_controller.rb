class Api::V1::ProjectsController < BaseController
  before_action :set_project, only: [:show,:update,:destroy]

  # GET -> api/v1/projects
  def index
    @projects = current_user.projects #will list only the projects of the current user.
    render json:{
      message: "Retrived all the projects of the user with email : #{current_user.email}.",
      user: current_user,
      projects: @projects
    },status: :ok
  end

  # POST -> api/v1/projects
  def create
    @project = current_user.projects.create(project_params)
    if @project.save
      render json:{
        message: "Successfully added the project to the signed in user.",
        user: current_user,
        project: @project
      },status: :created
    else
      render json:{
        message: @project.errors.full_messages
      },status: :unprocessable_entity
    end
  end

  # GET -> api/v1/projects/{id}
  def show
    render json:{
      message: "Successfully rendered all the projects of the signed in user.",
      user: current_user,
      project: @project
    },status: :ok
  end

  # PUT/PATCH -> api/v1/projects/{id}
  def update
    if @project.update(project_params)
      render json:{
        message: "Successfully updated the project with the id : #{params[:id]} of the current user.",
        user: current_user,
        updated_project: @project
      }, status: :accepted
    else
      render json:{
        message: @project.errors.full_messages
      },status: :not_acceptable
    end
  end

  # DELETE -> api/v1/projects/{id}
  def destroy
    if @project.destroy
      render json:{
        message: "Successfully deleted the project with the id : #{params[:id]} of the current user.",
        user: current_user,
        deleted_project: @project
      }, status: :ok
    else
      render json:{
        message: @project.errors.full_messages
      },status: :unprocessable_entity
    end
  end

  private
  # call back method
  def set_project
    @project = current_user.projects.find(params[:id])
  rescue ActiveRecord::RecordNotFound => exception
    render json:{
      error_message: exception.message
    }, status: :unauthorized
  end

  # params method
  def project_params
    params.require(:project).permit(:name, :project_type, :manager, :start_date, :end_date, :closure_status)
  end
end
