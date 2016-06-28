class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  rescue_from ActionView::MissingTemplate, with: :missing_template_error


  def missing_template_error(exception)
    Rails.logger.debug exception
    render plain: "we do not support that content-type[#{request.accept}]",
           status: :unsupported_media_type
  end
end
