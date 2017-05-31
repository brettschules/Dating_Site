class AddHosttoEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :host_id, :references, foreign_key: true
  end
end
