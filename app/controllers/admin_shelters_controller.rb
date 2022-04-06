class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetical_order
    @shelters_with_pending_apps = Shelter.with_pending_applications
  end

  def show
    binding.pry
    @shid = params[:id]
    @shelters = Shelter.find_by_sql("SELECT  'shelters'.* FROM "shelters" WHERE 'shelters'.'id' = #{@shid}")
  end
end
