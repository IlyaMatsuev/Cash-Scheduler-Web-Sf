/**
 * Created by Ilya Matsuev on 3/17/2021.
 */

public with sharing class ContactAssignAccountTriggerHandler implements ITriggerHandler {

    public void handle(TriggerContext context, ITriggerService service) {
        List<Contact> contacts = (List<Contact>) context.newList;
        Account cashSchedulerAccount = getCashSchedulerAccount();
        for (Contact contact : contacts) {
            if (String.isBlank(contact.AccountId)) {
                contact.AccountId = cashSchedulerAccount.Id;
            }
        }
    }

    private Account getCashSchedulerAccount() {
        List<Account> accounts = [
                SELECT Id
                FROM Account
                WHERE Name = :Label.CashSchedulerAccountName
                LIMIT 1
        ];
        if (accounts.isEmpty()) {
            throw new QueryException('There is no account with name: ' + Label.CashSchedulerAccountName);
        }
        return accounts.get(0);
    }
}
