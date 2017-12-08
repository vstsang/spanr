class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @company = Company.find(params[:company_id])
  end

  def new
    @company = Company.find(params[:company_id])
    @booking = Booking.new
    @timeslot = Timeslot.find(params[:timeslot_id])

    respond_to do |format|
      format.js
    end
  end

  def create
    @company = Company.find(params[:company_id])
    @booking = Booking.new(booking_params)

    @timeslot = Timeslot.find(params[:booking][:timeslot_id])
    @timeslot.booking = @booking

    if @booking.save
      redirect_to [@company, @booking]
    else
      flash.now[:alert] = "There was an error saving the booking. Please try again."
      render :new
    end
  end

  def edit
    @company = Company.find(params[:company_id])
    @booking = Booking.find(params[:id])
  end

  def destroy
    @company = Company.find(params[:company_id])
    @booking = Booking.find(params[:id])

    if  @booking.destroy
      flash[:notice] = "Booking was deleted successfully."
      redirect_to company_path(@company)
    else
      flash.now[:alert] = "There was an error deleting the booking. Please try again."
      render :show
    end
  end

  def reschedule_slots
    # receive a string with date, turn into dateime
    # select timeslots for the selected date
    # render a js file to pass times to client
    @selected_date = params[:date][:date].to_datetime
    @current_booking = Booking.find(params[:date][:current_booking_id])
    company = Company.find(params[:date][:company_id])

    # dev note: limits to one tradesman per company for now
    @timeslots_morning = Timeslot.where(tradesman: company.users.tradesman.first).where(start_time: @selected_date.beginning_of_day...@selected_date.at_midday)
    @timeslots_afternoon = Timeslot.where(tradesman: company.users.tradesman.first).where(start_time: @selected_date.at_midday..@selected_date.end_of_day)

    respond_to do |format|
      format.js
    end
  end

  def reschedule_confirm
    @company = Company.find(params[:company_id])
    @current_booking = Booking.find(params[:current_booking_id])
    @timeslot = Timeslot.find(params[:timeslot_id])
  end

  def reschedule_save
    @company = Company.find(params[:company_id])
    @current_booking = Booking.find(params[:current_booking_id])
    @timeslot = Timeslot.find(params[:timeslot_id])

    current_timeslot = @current_booking.timeslot
    @timeslot.booking = @current_booking
    current_timeslot.booking = nil

    if ( @timeslot.save && current_timeslot.save )
      flash[:notice] = "Booking was rescheduled successfully."
      redirect_to company_booking_path(@company, @current_booking)
    else
      flash.now[:alert] = "There was an error rescheduling the booking. Please try again."
      render :show
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :address, :mobile, :email, :notes)
  end
end
