class Admin::AdminController < ApplicationController
  before_action :check_if_admin

  private

  def check_if_admin
    unless current_user.is_admin
      redirect_to root_path, alert: 'You have to be logged in as admin.'
    end
  end
end