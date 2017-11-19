class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
  end

  def select_slots
    # receive a string with date, turn into dateime
    # select timeslots for the selected date
    # render a js file to pass times to client
    @selected_date = params[:date][:date].to_datetime
    company = Company.find(params[:date][:company_id])
    # dev note: limits to one tradesman per company for now
    @timeslots = Timeslot.where(tradesman: company.users.tradesman.first).where(start_time: @selected_date.beginning_of_day..@selected_date.end_of_day)
    respond_to do |f|
      f.js
    end
  end
end
