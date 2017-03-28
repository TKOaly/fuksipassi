class OverviewController < ApplicationController

  def index
    @participations = Participation.all
  end
end