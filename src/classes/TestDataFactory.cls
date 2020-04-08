/**
 * Created by mryzhkouskaya on 06.06.2019.
 */

public with sharing class TestDataFactory {

    public static List<Account> createAccounts( Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for ( Integer i = 0 ; i < numberOfAccounts ; i++ ) {
                Account account = new Account(Name = 'Test Account' + Math.random(), Description = 'account',
                        Phone = '(415) 419-8873', BillingStreet = '5353 W.Test Rd',
                        BillingCity = 'Testdale', BillingCountry = 'CA', Rating = 'Hot',
                        AccountNumber = ' Account Number ' + i
                );
                accounts.add(account);
        }
        return accounts;
    }
}