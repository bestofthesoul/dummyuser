class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |x|
      x.string :email
      x.string :password

      x.timestamps null: false
    end

    create_table :urls do |x|
      x.string  :short_url
      x.string  :long_url
      x.integer :click_count, default: 0
      x.integer :user_id

      x.timestamps null: false
    end

  end
end
