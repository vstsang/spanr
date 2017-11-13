class CompaniesController < ApplicationController
  def show
    @company = Company.find(params[:id])
    @selected_date = DateTime.new(2017,11,3)
    @timeslots = Timeslot.where(tradesman: @company.users.tradesman.first).where(start_time: @selected_date.beginning_of_day..@selected_date.end_of_day)
    respond_to do |f|
      f.html
      f.js
    end

  end
end
