class PagesController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @pages = Page.order("pages.position ASC")
  end
  
  def show
    @page = Page.find(params[:id])
  end
  
  def new
    @page = Page.new
    @page_count = Page.count + 1
  end
  
  def create
    #Instantiate a new object using form params
    @page = Page.new(params[:page])
    #save the page
    if @page.save
      # If the save succeeds, redirect to list action
      flash[:notice] = "Page created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix
      @page_count = Page.count + 1
      render('new')
    end
  end
  
  def edit
    @page = Page.find(params[:id])
    @page_count = Page.count
  end
  
  def update
    # Find a new object using form params
    @page = Page.find(params[:id])
    # update the page
    if @page.update_attributes(params[:page])
      # If the update succeeds, redirect to list action
      flash[:notice] = "Page updated."
      redirect_to(:action => 'show', :id => @page.id)
    else
      # If save fails, redisplay the form so user can fix
      @page_count = Page.count + 1
      render('edit')
    end    
  end
  
  def delete
    @page = Page.find(params[:id])  
  end
  
  def destroy
    Page.find(params[:id]).destroy
    flash[:notice] = "Page destroyed."
    redirect_to(:action => 'list')
  end
  
end


