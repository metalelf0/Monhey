class Movement < ActiveRecord::Base

  belongs_to :from_account, :class_name => "Account", :foreign_key => "from_account_id"
  belongs_to :to_account,   :class_name => "Account", :foreign_key => "to_account_id"

  validates_presence_of :from_account, :message => "can't be blank"
  validates_presence_of :to_account, :message => "can't be blank"

  validate :accounts_are_different

  private

  def accounts_are_different
    if (self.from_account == self.to_account)
      errors.add(:base, "Accounts should be different")
    end
  end

end
