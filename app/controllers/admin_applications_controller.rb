class AdminApplicationsController < ActionController::Base
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    @application = Application.find(params[:id])
###
#    get join info from ApplicationPets
###
    join_update = ApplicationPet.app_pet(@application.id, params[:petid])
    join_update.status = params[:status]
    join_update.save

    if @application.all_pets_approved
      @application.adopt_pet
      @application.status = "2"
      @application.save

    elsif @application.rejected_or_approved
     @application.status = "3"
     @application.save
    end
    redirect_to "/admin/applications/#{@application.id}/"
  end

  def new
  end

  def create
#    @application = Application.create!(application_params)
#   redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
 #   params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
