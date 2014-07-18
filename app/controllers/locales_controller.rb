class LocalesController < ApplicationController
  def change
    I18n.locale = params[:locale]
    redirect_to :back
  end
end