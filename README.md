# Menu API

### Development Setup

1. Ensure you run `bundle install`, and `rake db:setup`, prior to `rails s`

2. Your API should now be running on `localhost:3000`. To test it out, try adding the endpoints below:

### API Endpoints

#### /api/v1/menus

* retrieves all menu, by default, name sorted in ascending order
* e.g: `http://localhost:3000/api/v1/menus`

#### /api/v1/menus?q=searchQuery

* retrieves all menu with names that contain the `searchQuery`
* e.g: `http://localhost:3000/api/v1/menus?q=pizza`

#### /api/v1/menus?sort_by=sortKey&order_by=orderKey

* sortKey can be `name` or `price`
* orderKey can be `asc` or `desc`
* e.g: `http://localhost:3000/api/v1/menus?sort_by=name&order_by=asc`

#### /api/v1/menus?q=searchQuery&sort_by=sortKey&order_by=orderKey 

* retrieves all menu with names that contain the `searchQuery`
* search result will be sorted according to the order and sort key
* sortKey can be `name` or `price`
* orderKey can be `asc` or `desc`
* e.g: `http://localhost:3000/api/v1/menus?q=pizza&sort_by=name&order_by=asc`


