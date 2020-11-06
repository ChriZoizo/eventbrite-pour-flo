class IsAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :user, :is_admin?, :boolean
  end
end
