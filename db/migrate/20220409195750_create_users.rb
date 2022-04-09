class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :token, null: false

      t.timestamps
    end
    add_index :users, :token, unique: true
  end
end
