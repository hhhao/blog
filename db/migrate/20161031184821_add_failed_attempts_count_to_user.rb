class AddFailedAttemptsCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :failed_attempts_count, :integer
  end
end
