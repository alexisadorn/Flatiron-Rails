class AddHostColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :host, :boolean, default: false
  end
end
