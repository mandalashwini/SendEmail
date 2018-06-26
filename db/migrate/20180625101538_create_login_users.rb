class CreateLoginUsers < ActiveRecord::Migration
  def change
    create_table :login_users do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
