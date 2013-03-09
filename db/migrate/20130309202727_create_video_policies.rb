class CreateVideoPolicies < ActiveRecord::Migration
  def change
    create_table :video_policies do |t|
      t.string :video_id
      t.string :country
      t.integer :policy_id

      t.timestamps
    end
    add_index :video_policies, [:video_id, :country], :name => 'video_country', :order => {:video_id => :asc, :country => :asc}
    add_index :video_policies, [:country, :policy_id], :name => 'country_policy', :order => {:country => :asc, :policy_id => :asc}
  end
end
