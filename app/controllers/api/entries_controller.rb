class Api::EntriesController < Api::BaseController
  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:racer_id]}/entries"
    else
    end
  end

  def create
    if !request.accept || request.accept == "*/*"
      render plain: :nothing, status: :ok
    else
    end
  end

  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
    else
    end
  end
end
