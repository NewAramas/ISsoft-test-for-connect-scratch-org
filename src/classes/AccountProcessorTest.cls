@IsTest(seeAlldata = true)
public class AccountProcessorTest {
    @IsTest public static void AccountProcessorTestInner(){
        

        Account a = new Account();
        a.Name = 'Test Account';
        Insert a;
        
        Contact cont = new Contact();
        cont.FirstName = 'Marg';
        cont.LastName = 'Rizhk';
        cont.AccountId = a.Id;
        Insert cont;
        
        List<Id> listAccId = new List<Id>();
        listAccId.add(a.Id);
        
        Test.startTest();
        AccountProcessor.countContacts(listAccId);
        test.stopTest();
        
        Account Acc = [SELECT Number_of_Contacts__c FROM Account WHERE Id = :a.Id LIMIT 1];
        System.assertEquals(Integer.valueOf(Acc.Number_of_Contacts__c),1);

        
    }
}