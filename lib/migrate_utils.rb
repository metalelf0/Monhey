class MigrateUtils

  def MigrateUtils.migrate_and_save expense
    if expense.bancomat
      expense.account = Account.find_by_name("bancomat")
    else
      expense.account = Account.find_by_name("contanti")
    end
    expense.save!
  end
  
  def MigrateUtils.migrate_back_and_save expense
    if expense.account.name == "bancomat"
      expense.bancomat = true
    else
      expense.bancomat = false
    end
    expense.save!
  end
  
end
