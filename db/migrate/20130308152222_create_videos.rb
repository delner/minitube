class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos, {:id => false} do |t|
      t.string :id
      t.string :title

      t.timestamps
    end
    execute "ALTER TABLE videos ADD PRIMARY KEY (id);"
  end
end
