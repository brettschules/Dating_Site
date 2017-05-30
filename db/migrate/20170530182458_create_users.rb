class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :mgender
      t.boolean :fgender
      t.boolean :qgender
      t.integer :height
      t.string :picture_url
      t.string :city
      t.datetime :birthday
      t.string :phone_number
      t.string :email, unique: true
      t.string :password_digest
      t.boolean :men
      t.boolean :women
      t.boolean :genderqueer
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
