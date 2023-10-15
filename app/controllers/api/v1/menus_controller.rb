class Api::V1::MenusController < Api::V1::BaseController	
	def index
		@menus = data_scope.sorted_and_ordered_by(sort_by_params, order_by_params)
		render json: @menus
	end

	private

	def search_params
		params[:q].presence
	end

	def order_by_params
		params[:order_by].presence
	end

	def sort_by_params
		params[:sort_by].presence
	end

	def data_scope
		return default_data_scope unless search_params
		
		Menu.scoped_by_name(search_params)
	end

	def default_data_scope
		Menu
	end
end
