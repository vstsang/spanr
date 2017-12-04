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

  def destroy
=begin
    @booking = Booking.find(params[:id])

    if @booking.destroy
      flash[:notice] = "Booking was deleted successfully."
      redirect_to :back
    else
      flash.now[:alert] = "There was an error deleting the booking. Please try again."
      #render :show
    end
=end
  end

  private

  def booking_params
    params.require(:booking).permit(:first_name, :last_name, :address, :mobile, :email, :notes)
  end
end
