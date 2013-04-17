class SubjectsController < ApplicationController

  layout 'admin'
  
  before_filter :confirm_logged_in
  
  def index
    list
    render('list')
  end
  
  def list
    @subjects = Subject.order("subjects.position ASC")
  end
  
  def show
    @subject = Subject.find(params[:id])
  end
  
  def new
    @subject = Subject.new
    @subject_count = Subject.count + 1
  end
  
  def create
    #Instantiate a new object using form params
    @subject = Subject.new(params[:subject])
    #save the subject
    if @subject.save
      # If the save succeeds, redirect to list action
      flash[:notice] = "Subject created."
      redirect_to(:action => 'list')
    else
      # If save fails, redisplay the form so user can fix
      @subject_count = Subject.count + 1
      render('new')
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end
  
  def update
    # Find a new object using form params
    @subject = Subject.find(params[:id])
    # update the subject
    if @subject.update_attributes(params[:subject])
      # If the update succeeds, redirect to list action
      flash[:notice] = "Subject updated."
      redirect_to(:action => 'show', :id => @subject.id)
    else
      # If save fails, redisplay the form so user can fix
      @subject_count = Subject.count + 1
      render('edit')
    end    
  end
  
  def delete
    @subject = Subject.find(params[:id])  
  end
  
  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject destroyed."
    redirect_to(:action => 'list')
  end
  
end


