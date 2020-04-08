public class AccountProcessor {
    @future(callout=true)
    public static void countContacts (List<Id> accountIds){
        List<Account> listAccounts = [Select Id, Number_of_Contacts__c,(SELECT Id FROM Contacts) from Account Where Id IN :accountIds];
        for(Account acct: listAccounts){
            List<Contact> listContacts = acct.Contacts;
            acct.Number_of_Contacts__c = listContacts.size();
        }
        update listAccounts;
    }
}