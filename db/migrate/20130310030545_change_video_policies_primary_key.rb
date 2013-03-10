class ChangeVideoPoliciesPrimaryKey < ActiveRecord::Migration
  def up
    remove_column :video_policies, :id
    #execute "ALTER TABLE `video_policies` DROP PRIMARY KEY;"
    execute "ALTER TABLE `video_policies` ADD PRIMARY KEY (`video_id`, `country`);"
  end

  def down
  end
end
