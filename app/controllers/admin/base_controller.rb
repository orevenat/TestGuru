class Admin::BaseController < ApplicationController
  AUTH_ERROR = 'You are not authorized to view this page.'.freeze

  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: AUTH_ERROR unless current_user.admin?
  end
end
