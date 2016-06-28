class Api::ResultsController < Api::BaseController
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found_error


  def index
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:race_id]}/results"
    else
      @race = Race.find(params[:race_id])
      # fresh_when(last_modified: @results.max(:updated_at))
      @results = @race.entrants

      if stale?(last_modified: @results.max(:updated_at))
        render "index"
      end
    end
  end

  def create
    if !request.accept || request.accept == "*/*"
      render plain: :nothing, status: :ok
    else
      @race = Race.find(params[:race_id])
    end
  end

  def show
    if !request.accept || request.accept == "*/*"
      render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
    else
      @race = Race.find(params[:race_id])
      @result = @race.entrants.find(params[:id])
      render "show"
    end
  end

  def update
    @race = Race.find(params[:race_id])
    @result = @race.entrants.find(params[:id])
    result = result_params

    if result
      if result[:swim]
        @result.swim = @result.race.race.swim
        @result.swim_secs = result[:swim].to_f
      end
      if result[:t1]
        @result.t1 = @result.race.race.t1
        @result.t1_secs = result[:t1].to_f
      end
      if result[:bike]
        @result.bike = @result.race.race.bike
        @result.bike_secs = result[:bike]
      end
      if result[:t2]
        @result.t2 = @result.race.race.t2
        @result.t2_secs = result[:t2].to_f
      end
      if result[:run]
        @result.run = @result.race.race.run
        @result.run_secs = result[:run].to_f
      end
    end

    @result.save
    render json: @race
  end

  def destroy
    @race = Race.find(params[:race_id])
    @result = @race.entrants.find(params[:id])
  end

  private

    def result_params
      params.require(:result).permit(:swim, :t1, :bike, :t2, :run)
    end

    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_result
      @result = @race.entrants.find(params[:id])
    end

    def not_found_error
      msg = "woops: connot find race[#{params[:race_id]}] or ressult[#{:id}]"
      respond_to do |format|
        format.xml do
          render status: :not_found,
                 template: "api/races/error_msg.xml",
                 locals: { msg: msg }
        end
        format.json do
          render status: :not_found,
                 template: "api/races/error_msg.json",
                 locals: { msg: msg }
        end
        format.any do
          render status: :not_found,
                 template: "api/races/error_msg.json",
                 locals: { msg: msg }
        end
      end
    end
end
