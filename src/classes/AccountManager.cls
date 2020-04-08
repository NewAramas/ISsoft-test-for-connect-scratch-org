@RestResource(urlMapping = '/Accounts/*/contacts')
global with sharing class AccountManager{
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('/Accounts/','/contacts');
        system.debug(accountId);
        Account objAccount = [Select Id,Name, (Select Id,Name From Contacts) From Account Where Id =: accountId Limit 1];
        return objAccount;
    }
}