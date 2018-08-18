class AddPrivacyPolicyConsentToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :privacy_policy_consent, :boolean, null: false, default: false
  end
end
