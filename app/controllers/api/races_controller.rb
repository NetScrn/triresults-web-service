class Api::RacesController < Api::BaseController
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found_error

  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
    else
    end
  end

  def create
    if !request.accept || request.accept == "*/*"
      render plain: "#{params[:race][:name]}", status: :ok
    else
      @race = Race.new(race_params)
      if @race.save
        render plain: @race.name, status: :created
      else
        render plain: @race.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:id]}"
    else
      @race = Race.find(params[:id])
      render "show"
    end
  end

  # PUT,PATCH /api/races/:id
  def update
    @race = Race.find(params[:id])
    Rails.logger.debug("method=#{request.method}")

    @race.update(race_params)
    render json: @race
  end

  def destroy
    @race = Race.find(params[:id])
    @race.destroy
    render :nothing=>true, :status => :no_content
  end

  private

    def race_params
      params.require(:race).permit(:name, :date)
    end



    def not_found_error
      respond_to do |format|
        format.xml do
          render status: :not_found,
                 template: "api/races/error_msg.xml",
                 locals: { msg: "woops: connot find race[#{params[:id]}]"}
        end
        format.json do
          render status: :not_found,
                 template: "api/races/error_msg.json",
                 locals: { msg: "woops: connot find race[#{params[:id]}]"}
        end
        format.any do
          render status: :not_found,
                 template: "api/races/error_msg.json",
                 locals: { msg: "woops: connot find race[#{params[:id]}]"}
        end
      end
    end
end
