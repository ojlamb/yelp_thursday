class AddUserToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :rspec, :string
  end
end
