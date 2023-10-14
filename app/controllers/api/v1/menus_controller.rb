class Api::V1::MenusController < ApplicationController
	def index
		@menus ||= if params[:q].present?
			Menu.where("name ILIKE ?", "%#{params[:q]}%")
		elsif params[:sort_by].present?
			Menu.order("#{params[:sort_by]} #{params[:order_by]}")
		else 
			Menu.all
		end
		render json: @menus
	rescue ActiveRecord::StatementInvalid
		render json: 'Error', status: :unprocessable_entity
	end
end
