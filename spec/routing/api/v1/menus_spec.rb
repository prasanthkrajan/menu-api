require "rails_helper"

RSpec.describe Api::V1::MenusController, type: :routing do
  base_folder = 'api/v1'

  it 'routes to index when hits /api/v1/menus' do
    expect(get("/#{base_folder}/menus")).to route_to({controller: "#{base_folder}/menus", action: 'index'})
  end

  it 'routes to index when hits /api/v1/menus?q=pizza with search query' do
    expect(get("/#{base_folder}/menus")).to route_to({controller: "#{base_folder}/menus", action: 'index'})
  end

  it 'routes to index when hits /api/v1/menus?sort_by=name&order_by=asc with sorting params' do
    expect(get("/#{base_folder}/menus")).to route_to({controller: "#{base_folder}/menus", action: 'index'})
  end

  it 'does not support other generic routes' do
    expect(post("/#{base_folder}/menus")).not_to be_routable
    expect(get("/#{base_folder}/menus/1")).not_to be_routable
    expect(delete("/#{base_folder}/menus/1")).not_to be_routable
    expect(put("/#{base_folder}/menus/1")).not_to be_routable
    expect(patch("/#{base_folder}/menus/1")).not_to be_routable
  end
end