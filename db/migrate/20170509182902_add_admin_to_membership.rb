class AddAdminToMembership < ActiveRecord::Migration
  def up
    add_column :memberships, :admin, :boolean, default: false, null: false
    Membership.all.each { |m| m.admin = true }
  end

  def change
    remove_column :memberships, :admin
  end
end
