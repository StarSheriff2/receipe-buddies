class AddIndextoVote < ActiveRecord::Migration[6.1]
  def change
    add_index(:votes, [:user_id, :opinion_id], unique: true)
  end
end
