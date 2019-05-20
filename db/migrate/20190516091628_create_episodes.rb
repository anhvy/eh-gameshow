class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.datetime :happen_date
      t.text :team_ids, array: true, default: []

      t.timestamps
    end
  end
end
