# Scaffolding generated by Casein v5.1.1.5

module Casein
  class SprintsController < Casein::CaseinController
  
    ## optional filters for defining usage according to Casein::AdminUser access_levels
    # before_filter :needs_admin, :except => [:action1, :action2]
    # before_filter :needs_admin_or_current_user, :only => [:action1, :action2]
  
    def index
      @casein_page_title = 'Sprints'
  		@sprints = Sprint.order(sort_order(:start)).paginate :page => params[:page]
    end
  
    def show
      @casein_page_title = 'View sprint'
      @sprint = Sprint.find params[:id]
    end
  
    def new
      @casein_page_title = 'Add a new sprint'
    	@sprint = Sprint.new
    end

    def create
      @sprint = Sprint.new sprint_params
    
      if @sprint.save
        flash[:notice] = 'Sprint created'
        redirect_to casein_sprints_path
      else
        flash.now[:warning] = 'There were problems when trying to create a new sprint'
        render :action => :new
      end
    end
  
    def update
      @casein_page_title = 'Update sprint'
      
      @sprint = Sprint.find params[:id]
    
      if @sprint.update_attributes sprint_params
        flash[:notice] = 'Sprint has been updated'
        redirect_to casein_sprints_path
      else
        flash.now[:warning] = 'There were problems when trying to update this sprint'
        render :action => :show
      end
    end
 
    def destroy
      @sprint = Sprint.find params[:id]

      @sprint.destroy
      flash[:notice] = 'Sprint has been deleted'
      redirect_to casein_sprints_path
    end
  
    private
      
      def sprint_params
        params.require(:sprint).permit(:start, :finish, :number)
      end

  end
end