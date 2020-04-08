/**
 * Created by mryzhkouskaya on 24.01.2020.
 */
@IsTest
public with sharing class ClassForCallingFromAnotherOrgTest {

    @IsTest
    static void test_getAllChildren() {

    }

    public static Account getAccount(String name) {
        Account accountExemplar = new Account();
        accountExemplar.Name = name;
        insert accountExemplar;

        return accountExemplar;
    }

    public static Contact getContact(Account accountExemplar) {
        Contact contactExemplar = new Contact();
        contactExemplar.AccountId = accountExemplar.Id;
        contactExemplar.LastName = accountExemplar.Name.split(' ').get(0);
        contactExemplar.OwnerId = UserInfo.getUserId();
        insert contactExemplar;

        return contactExemplar;
    }

}