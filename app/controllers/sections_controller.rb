class SectionsController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @sections = Section.order("sections.position ASC")
    @section_count = Section.count + 1
  end
  
  def show
    @section = Section.find(params[:id])
  end
  
  def new
    @section = Section.new
    @section_count = Section.count + 1
  end
  
  def create
    #Instantiate a new object using form params
    @section = Section.new(params[:section])
    #save the section
    if @section.save
      # If the save succeeds, redirect to list action
      flash[:notice] = "Section created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix
      @section_count = Section.count + 1
      render('new')
    end
  end
  
  def edit
    @section = Section.find(params[:id])
    @section_count = Section.count
  end
  
  def update
    # Find a new object using form params
    @section = Section.find(params[:id])
    # update the section
    if @section.update_attributes(params[:section])
      # If the update succeeds, redirect to list action
      flash[:notice] = "Section updated."
      redirect_to(:action => 'show', :id => @section.id)
    else
      # If save fails, redisplay the form so user can fix
      @section_count = Section.count + 1
      render('edit')
    end    
  end
  
  def delete
    @section = Section.find(params[:id])  
  end
  
  def destroy
    Section.find(params[:id]).destroy
    flash[:notice] = "Section destroyed."
    redirect_to(:action => 'list')
  end
  
end


