class LinkedDatasController < ApplicationController
  def foaf
    if params[:id]
      @request = ActiveRecord::Base.connection.select_all()
    else
      @request = ActiveRecord::Base.connection.select_all()
    end

    render :template => "request_objects"
  end
end
