class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :fullname, null: false
      t.string :photo
      t.string :cover_image

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
