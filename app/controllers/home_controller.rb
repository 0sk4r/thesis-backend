class HomeController < ApplicationController

  before_action :authenticate_user!, only: %i[test]
  def index
    render :index
  end

  def test
    render :test
  end

end