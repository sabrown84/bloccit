class WelcomeController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def about
  end

  def contact
  end

  def faq
  end
end
