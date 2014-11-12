class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
      t.string :name
      t.string :street
      t.string :city
      t.integer :zip_code
      t.string :mobile_number
      t.string :email_address
      t.string :position
      t.string :employer
      t.string :blog_url
      t.string :twitter
      t.string :instagram
      t.string :facebook
      t.string :linkedin
    end
  end
end
