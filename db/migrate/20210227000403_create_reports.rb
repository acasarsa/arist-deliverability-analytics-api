class CreateReports < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :reports, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.text :sender
      t.text :message
      t.belongs_to :device, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :reports, :created_at
  end
end
