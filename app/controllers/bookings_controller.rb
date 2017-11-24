class BookingsController < ApplicationController
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
    @booking = Booking.new

    @timeslot = Timeslot.find(params[:booking][:timeslot_id])
    @timeslot.booking = @booking

    @booking.notes = params[:booking][:notes]
    @booking.customer_id = 1

    if @booking.save
      flash[:notice] = "Booking was saved."
      redirect_to @company
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
  end
=end
end
