class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  def respond_with(resource, options = {})
    if resource.persisted?
      render json:{
        status: 200,
        message: "User signed up successfully.",
        data: resource
      },status: :ok
    else
      render json:{
        message: "User was not able to signup.",
        error: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end
end
