class CreatePingResults < ActiveRecord::Migration[6.1]
  def change
    create_table :ping_results do |t|
      t.boolean :success, null: false
      t.integer :transmitted, null: false
      t.integer :received, null: false
      t.float :min_rtt
      t.float :avg_rtt
      t.float :max_rtt
      t.float :mdev_rtt
      t.references :host, null: false, foreign_key: true, index: false

      t.timestamps
    end
    add_index :ping_results, [:host_id, :created_at], unique: true
  end
end
