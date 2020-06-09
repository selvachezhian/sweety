class BloodGlucosesController < ApplicationController
  def index
    @blood_glucoses = @user.blood_glucoses.today
  end

  def new
    @blood_glucose = @user.blood_glucoses.new
  end

  def create
    @blood_glucose = @user.blood_glucoses.new(blood_glucose_params)
    if @blood_glucose.save
      flash[:notice] = 'Blood glucose reading value added successfully'
      redirect_to action: :index
    else
      flash[:error] = 'There is some problem in saving your reading value'
      render action: :create
    end
  end

  def this_month_till_date
    @blood_glucoses = @user.blood_glucoses.this_month_till
  end

  def monthly
    if params[:date].present?
      @selected_month = Date.civil(params[:date][:year].to_i, params[:date][:month].to_i).to_datetime
    else
      @selected_month = Time.zone.now
    end
    @blood_glucoses = @user.blood_glucoses.by_dates(@selected_month.beginning_of_month, @selected_month.end_of_month)
  end

  def custom
    if params[:from].present? && params[:to].present?
      @from = Date.civil(params[:from][:year].to_i, params[:from][:month].to_i, params[:from][:day].to_i).to_datetime
      @to = Date.civil(params[:to][:year].to_i, params[:to][:month].to_i, params[:to][:day].to_i).to_datetime
    else
      @from = Time.zone.now
      @to = Time.zone.now
    end
    @blood_glucoses = @user.blood_glucoses.by_dates(@from.beginning_of_day, @to.end_of_day)
  end

  private

  def blood_glucose_params
    params.require(:blood_glucose).permit(:value, :reading_date)
  end
end
