class CreateApiV1JwtDenylist < ActiveRecord::Migration[6.1]
  def change
    create_table :api_v1_jwt_denylist do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false

      t.timestamps
    end
    add_index :api_v1_jwt_denylist, :jti
  end
end
