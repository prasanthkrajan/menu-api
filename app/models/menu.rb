class Menu < ApplicationRecord
	# default scope, is by name, in ascending order
	DEFAULT_ORDER_BY = 'asc'
	DEFAULT_SORT_BY = 'name'

	scope :scoped_by_name, -> (name) { where("name ILIKE ?", "%#{name}%") }
	scope :sorted_and_ordered_by, -> (sort_by, order_by) { 
		sort_by ||= DEFAULT_SORT_BY
		order_by ||= DEFAULT_ORDER_BY 

		order(sort_by => order_by) 
	}
end
