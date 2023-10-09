class TopsController < ApplicationController
  skip_before_action :require_login, only: %i[top index]
  
  def top
  end
  
  def index
  end
end
