class AddSubscriberToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscriber, :boolean, default: false
  end
end
