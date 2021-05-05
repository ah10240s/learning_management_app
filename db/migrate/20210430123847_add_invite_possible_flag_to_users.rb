class AddInvitePossibleFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invite_possible_flag, :boolean, default: true
    add_column :users, :invite_user_id, :text
  end
end
