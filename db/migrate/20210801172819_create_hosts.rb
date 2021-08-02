class CreateHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hosts do |t|
      t.inet :ipaddr, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :hosts, :ipaddr, unique: true
  end
end
