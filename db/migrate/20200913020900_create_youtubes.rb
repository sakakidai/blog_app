class CreateYoutubes < ActiveRecord::Migration[6.0]
  def change
    create_table :youtubes do |t|
      t.integer :article_id
      t.string :video_id

      t.timestamps
    end
  end
end
