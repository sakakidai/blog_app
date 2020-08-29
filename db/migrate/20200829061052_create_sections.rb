class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.belongs_to :article
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
