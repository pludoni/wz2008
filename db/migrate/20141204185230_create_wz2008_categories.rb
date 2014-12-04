class CreateWz2008Categories < ActiveRecord::Migration
  def change
    create_table :wz2008_categories do |t|
      t.string :wz_code
      t.string :description_en
      t.string :description_de
      t.string :isic
      t.string :ancestry
      t.string :hierarchy
      t.integer :ancestry_depth, default: 0
    end
    add_index :wz2008_categories, :ancestry
    add_index :wz2008_categories, :ancestry_depth
    add_index :wz2008_categories, :hierarchy
  end
end
