class DemoController < ApplicationController
  
  layout 'admin'
  
  def index
    # redirect_to(:action => 'other_hello')
  end
  
  def hello
    @array = [1,2,3,4,5]
    @id = params[:id]
    @page = params[:page]
  end
  
  def other_hello
    render(:text => 'Hello Everyone!')
  end
  
  def javascript
  end
  
  def text_helpers
  end
  
  def escape_output
  end
  
end
