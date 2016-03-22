class ChangeTrackVotes < ActiveRecord::Migration
  def change
    change_table :tracks do |t|
      t.integer :total_votes, default: 0
    end
  end
end