class ListingsController < ApplicationController
  
  
 before_action :set_listing, only: [:show, :edit, :update, :destroy] 
 before_action :authenticate_model!, only: [:new, :show, :edit, :update, :destroy]
 
  
  def index
    @listings = Listing.all
  end
  
  def new 
    @listing = Listing.new
  end
  
  def create
    @listing = Listing.new(listing_params)
    if @listing.save
     if params[:listing][:avatar].blank?
        redirect_to listings_path
     else
          render :action => 'crop'
     end
    else
      render :new
    end
  end
  
  def edit
    
  end
  
   def update
     @listing = Listing.find(params[:id])
    if @listing.update(listing_params)
      flash[:success] = "Your recipe was updated succesfully!"
      if params[:listing][:avatar].blank?
        redirect_to listings_path
      else
        render :action => 'crop'
      end
    else
      render :edit
    end
   end
  
  
  def destroy
    Listing.find(params[:id]).destroy
    redirect_to listings_path
  end
  
  private
  
    def listing_params
      params.require(:listing).permit(:name, :description, :avatar)
    end
    
    def set_listing
      @listing = Listing.find(params[:id])
    end
  
  
end
