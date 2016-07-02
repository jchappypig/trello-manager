# Scaffolding generated by Casein v5.1.1.5

module Casein
  class MemebersController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Memebers'
  		@memebers = Memeber.order(sort_order(:full_name)).paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View memeber'
      @memeber = Memeber.find params[:id]
    end
  
    def new
      @casein_page_title = 'Add a new memeber'
    	@memeber = Memeber.new
    end

    def create
      @memeber = Memeber.new memeber_params
    
      if @memeber.save
        flash[:notice] = 'Memeber created'
        redirect_to casein_memebers_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new memeber'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update memeber'
      
      @memeber = Memeber.find params[:id]
    
      if @memeber.update_attributes memeber_params
        flash[:notice] = 'Memeber has been updated'
        redirect_to casein_memebers_path
      else
        flash.now[:warning] = 'There were problems when trying to update this memeber'
        render :action => :show
      end
    end
 
    def destroy
      @memeber = Memeber.find params[:id]

      @memeber.destroy
      flash[:notice] = 'Memeber has been deleted'
      redirect_to casein_memebers_path
    end
  
    private
      
      def memeber_params
        params.require(:memeber).permit(:full_name, :trello_identifier)
      end

  end
end