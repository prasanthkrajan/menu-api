class Api::V1::MenusController < ApplicationController
	def index
		@menus = if params[:q].present?
			Menu.where("name ILIKE ?", "%#{params[:q]}%")
		else 
			Menu.all
		end
		render json: @menus
	end
end
