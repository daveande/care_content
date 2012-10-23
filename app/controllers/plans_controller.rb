class PlansController < ApplicationController
  def index
    @plans = Plan.all(:order => :max_downloads)
  end
end
