class Api::V1::MenusController < ApplicationController
	DEFAULT_ORDER_BY = 'asc'
	DEFAULT_SORT_BY = 'name'
	
	def index
		@menus = if search_params
			Menu.where("name ILIKE ?", "%#{search_params}%")
					.order("#{sort_by_params} #{order_by_params}")
		else
			Menu.order("#{sort_by_params} #{order_by_params}")
		end

		render json: @menus
	rescue ActiveRecord::StatementInvalid
		render json: 'Error', status: :unprocessable_entity
	end

	private

	def search_params
		params[:q].presence
	end

	def order_by_params
		params[:order_by].presence || DEFAULT_ORDER_BY
	end

	def sort_by_params
		params[:sort_by].presence || DEFAULT_SORT_BY
	end
end
