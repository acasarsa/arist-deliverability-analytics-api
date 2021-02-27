class CreateHeartbeats < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :heartbeats, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.belongs_to :device, null: false, foreign_key: true, type: :uuid
      t.datetime :created_at, null: false
    end
    add_index :heartbeats, :created_at
  end
end
