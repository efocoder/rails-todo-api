class CreateApiV1Todos < ActiveRecord::Migration[6.1]

  def change
    create_table :api_v1_todos do |t|
      t.string :title, null: false
      t.string :description
      t.string :status, null: false, default: 'NEW'
      t.integer :user_id

      t.timestamps
    end
  end
end
