class Admin::BaseController < ApplicationController
  before_action :authenticate_user

  layout 'admin_layout'
  def authenticate_user
    redirect_to new_user_session_path unless current_user&.admin?
  end
end
