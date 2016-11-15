class AddResetPasswordDigestToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reset_password_digest, :string
  end
end
