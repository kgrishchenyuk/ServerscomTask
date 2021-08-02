class Api::V1::HostsController < ApplicationController
  def show
    @host = Host.find(params[:id])

    if @host
      begin
        start_time = params[:start]&.to_time
        end_time = params[:end]&.to_time
      rescue ArgumentError
        return render json: { error: "Invalid time format" }
      end
      
      @ping_results = @host.ping_results.where(created_at: start_time..end_time)
    else
      render json: { host: "not found" }, status: :not_found
    end
  end

  def create
    @host = Host.where(host_params).where(active: false).first
    
    if @host
      @host.update(active: true)  
      render status :ok
    else
      @host = Host.new(host_params)

      if @host.save
        render status: :created
      else
        render json: @host.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    host = Host.where(host_params).where(active: true).first

    if host&.active
      host.update(active: false)
    else
      render json: { host: "not found" }, status: :not_found
    end
  end

private

  def host_params
    params.require(:host).permit(:ipaddr)
  end
end
