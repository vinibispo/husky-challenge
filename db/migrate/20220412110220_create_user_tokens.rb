class CreateUserTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tokens do |t|
      t.string :token, null: false
      t.datetime :revoked_at, null: true
      t.datetime :confirmed_at, null: true
      t.references :user

      t.timestamps
    end
    add_index :user_tokens, :token, unique: true
  end
end
