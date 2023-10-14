class Api::V1::MenusController < ApplicationController
	def index
		@menus = Menu.all
		render json: @menus
	end
end
