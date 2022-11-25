class Api::V1::ProfilesController < BaseController
  before_action :set_profile, only: %i[ show update destroy ]

  # GET -> api/v1/user_profiles
  def index
    @user_profile = current_user.profile
    if @user_profile
      render json:{
        message: "Successfully rendered user profile.",
        user: current_user,
        profile: @user_profile
      }, status: :ok
    else
      render json:{
        message: "The user doesnot have a profile, please create one.",
        user: current_user
      }, status: :unprocessable_entity
    end
  end

  # GET -> api/v1/user_profiles/1
  def show
    @user_profile = current_user.profile
    if @user_profile
      render json:{
        message: "Successfully rendered user profile.",
        user: current_user,
        profile: @user_profile
      }, status: :ok
    else
      render json:{
        message: "The user doesnot have a profile, please create one.",
        user: current_user
      }, status: :unprocessable_entity
    end
  end

  # POST /user_profiles
  def create
    @user_profile = current_user.profile.create(profile_params)

    if @user_profile.email.equals?(current_user.email)
      if @user_profile.save
        render json:{
          message: "Successfully created an user profile.",
          user: current_user,
          profile: @user_profile
        }, status: :created
      else
        render json:{
          message: "Unable to create the user profile.",
          user: current_user,
          error: @user_profile.errors.full_messages
        }, status: :unprocessable_entity
      end
    else
      render json:{
        message: "The logged in email and the provided email are different.",
        user: current_user
      }, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /user_profiles/1
  def update
    if current_user.profile.update(profile_params)
      render json:{
        message: "Successfully updated the user profile",
        user: current_user,
        profile: current_user.profile
      }, status: :accepted
    else
      render json:{
        message: "Unable to update the user profile",
        user: current_user,
        profile: current_user.profile
      }, status: :unprocessable_entity
    end
  end

  # DELETE /user_profiles/1
  def destroy
    if current_user.profile.destroy
      render json:{
        message: "Successfully deleted the user profile",
        user: current_user
      }, status: :ok
    else
      render json:{
        message: "Unabe to delete the user profile",
        user: current_user,
        error: current_user.profile.error_message
      }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @user_profile = current_user.profile
    rescue ActiveRecord::RecordNotFound => exception
      render json:{
        error_message: exception.message
      }, status: :unauthorized
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :phone, :status, :joining_date, :salary)
    end
end
