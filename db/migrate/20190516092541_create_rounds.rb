class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.integer :episode_id
      t.text :question_ids, array: true, default: []

      t.timestamps
    end
  end
end
