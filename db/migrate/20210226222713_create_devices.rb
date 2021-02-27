class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :devices, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.text :phone_number
      t.text :carrier
      t.datetime :disabled_at
      t.index :created_at
      
      t.timestamps
    end
  end
end
