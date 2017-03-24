class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.string :handle, null: false, limit: 40, index: true
      t.string :content, null: false
      t.timestamp :created_at, null:false, index: true
    end
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE tweets
          ALTER COLUMN created_at
          SET DEFAULT NOW();
        SQL
      end
    end
  end
end
