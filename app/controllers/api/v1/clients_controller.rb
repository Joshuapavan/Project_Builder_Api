class Api::V1::ClientsController < BaseController
  before_action :set_client, only: [:show,:update,:destroy]

  # GET -> api/v1/clients
  def index
    @clients = Client.all
    render json:{
      message: "Rendered all existing clients",
      clients: @clients
    }, status: :ok
  end

  # GET -> api/v1/clients/{id}
  def show
    if @client
      render json: {
        message: "Rendered client with id #{params[:id]}",
        client: @client
      }, status: :found
    end
  end

  # POST -> api/v1/clients
  def create
    @client = Client.create(client_params)
    if @client.save
      render json:{
        message: "Sucessfully added client.",
        client: @client
      }, staus: :created
    else
      render json:{
        message: "Unable to save the client.",
        error: @client.error_message.full
      }, status: :bad_request
    end
  end

  # PUT/PATCH -> api/v1/clients/{id}
  def update
    if @client.update(client_params)
      render json:{
        message: "Successfully updated client.",
        client: @client
      }, status: :accepted
    else
      render json:{
        message: "Unable to update client",
        error: @client.error_message.full
      }, status: :not_acceptable
    end
  end

  # DELETE -> api/v1/clients{id}
  def destroy
    if @client.destroy
      render json:{
        message: "Successfully deleted the client.",
        client: @client
      }, status: :ok
    else
      render json:{
        message: "Unable to update client",
        error: @client.error_message.full
      }, status: :unprocessable_entity
    end
  end

  private
  def set_client
    @client = Client.find(params[:id])
  rescue ActiveRecord::RecordNotFound => exception
    render json:{
      error_message: exception.message
    }, status: :not_found
  end

  def client_params
    params.require(:client).permit(:name,:description,:email,:primary_contact_name)
  end
end
