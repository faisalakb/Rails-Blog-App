class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio posts_counter])
  end

  def require_user
    redirect_to root_path unless @current_user
  end

  # attr_reader :current_user

  def index; end
end
