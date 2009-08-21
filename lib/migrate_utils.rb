class MigrateUtils

  def MigrateUtils.migrate_and_save expense
    if expense.bancomat
      expense.account = Account.find_by_name("bancomat")
    else
      expense.account = Account.find_by_name("contanti")
    end
    expense.save!
  end
  
end
