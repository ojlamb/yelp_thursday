class RemoveRspecFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :rspec
  end
end
