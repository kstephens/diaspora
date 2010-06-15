class StatusMessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @status_messages = StatusMessage.all
    @friends = Friend.all
  end
  
  def create
    @status_message = StatusMessage.new(params[:status_message])
    if @status_message.save
      flash[:notice] = "Successfully created status message."
      redirect_to status_messages_url
    else
      render :action => 'new'
    end
  end
  
  def new
    @status_message = StatusMessage.new
  end
  
  def destroy
    @status_message = StatusMessage.first(:conditions => {:id => params[:id]})
    @status_message.destroy
    flash[:notice] = "Successfully destroyed status message."
    redirect_to status_messages_url
  end
  
  def show
    @status_message = StatusMessage.first(:conditions => {:id => params[:id]})
    
    respond_to do |format|
      format.html 
      format.xml { render :xml => @status_message }
      format.json { render :json => @status_message }
    end
  end
end