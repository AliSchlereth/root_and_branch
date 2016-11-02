class AddStatusIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :status, foreign_key: true
  end
end
