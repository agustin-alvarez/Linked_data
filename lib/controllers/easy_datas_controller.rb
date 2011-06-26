class EasyDatasController < ApplicationController
  def show
    if params[:id]
      @request = ActiveRecord::Base.connection.select_all()
    else
      @request = ActiveRecord::Base.connection.select_all()
    end

     
  end
end
