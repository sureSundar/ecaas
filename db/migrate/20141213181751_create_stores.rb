class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :description
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
