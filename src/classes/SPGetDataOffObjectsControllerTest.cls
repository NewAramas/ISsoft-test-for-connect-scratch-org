/**
 * Created by mryzhkouskaya on 04.06.2019.
 */
@IsTest
public class SPGetDataOffObjectsControllerTest {

    @IsTest
    static void testGetAllObjectNames() {

        List<ObjectOrFieldNamesWrapper> listSObjects = new List<ObjectOrFieldNamesWrapper>();

        Test.startTest();
        listSObjects = GetDataOffObjectsController.getAllObjectNamesIntoPicklist();
        Test.stopTest();

        System.assertEquals('Account', listSObjects[0].APIName);
        System.assertNotEquals('Contact',listSObjects[0].APIName);

    }

    @IsTest
    static void testGetFieldsNames() {

        Test.startTest();
        String resultJSON = GetDataOffObjectsController.getFieldsNamesIntoPickList('Account');
        List<ObjectOrFieldNamesWrapper> listFieldsOfAccount =
                (List<ObjectOrFieldNamesWrapper>)JSON.deserialize(resultJSON, List<ObjectOrFieldNamesWrapper>.class);
        Test.stopTest();

        System.assertEquals('Description', listFieldsOfAccount[0].APIName);
        System.assertNotEquals('Account Description',listFieldsOfAccount[0].APIName);

    }

    @IsTest
    static void testGetRecordsOfSelectedFields() {

        String testObjectName = 'Account';

        List<String> listFieldNames = new List<String>();
        listFieldNames.add('AccountNumber');
        listFieldNames.add('Phone');
        listFieldNames.add('Name');

        List<Account> lstAccountsToInsert = TestDataFactory.createAccounts(3);
        insert lstAccountsToInsert;

        Test.startTest();
        List<Account> lstAccountFromDataFactory = [SELECT AccountNumber, Phone, Name
                                                   FROM Account
                                                   LIMIT 5];

        String resultJSON = GetDataOffObjectsController.getRecordsOfSelectedFields(testObjectName,listFieldNames);
        List<Account> listRecordObjects =
                (List<Account>)JSON.deserialize(resultJSON, List<Account>.class);

        Test.stopTest();

        System.assertEquals(lstAccountFromDataFactory[0], listRecordObjects[0]);
        System.assertEquals(lstAccountFromDataFactory[1], listRecordObjects[1]);
        System.assertEquals(lstAccountFromDataFactory[2], listRecordObjects[2]);

        System.assertEquals(lstAccountFromDataFactory[0].Name, listRecordObjects[0].Name);

        System.assertNotEquals(lstAccountFromDataFactory[0], listRecordObjects[2]);
    }

    @IsTest
    static void testSortRecordsByFieldName() {

        List<Account> lstAccountsToInsert = TestDataFactory.createAccounts(3);
        insert lstAccountsToInsert;

        Map<String, String> mapIdToFieldName = new Map<String, String>();

        for(Account curAccount: lstAccountsToInsert){
            mapIdToFieldName.put(curAccount.Id, curAccount.Name);
        }

        Test.startTest();

        List<Account> lstAccountFromdataFactory = [SELECT AccountNumber, Phone, Name
                                                   FROM Account
                                                   ORDER BY Name
                                                   LIMIT 5 ];

        List<SPnewWrapper> listSortSPnewWrappers = GetDataOffObjectsController.sortRecordsByFieldName(mapIdToFieldName);

        Test.stopTest();

        System.assertEquals(lstAccountFromdataFactory[0].Name, listSortSPnewWrappers[0].fieldName);
        System.assertEquals(lstAccountFromdataFactory[1].Name, listSortSPnewWrappers[1].fieldName);
        System.assertEquals(lstAccountFromdataFactory[2].Name, listSortSPnewWrappers[2].fieldName);

        System.assertNotEquals(lstAccountFromdataFactory[0].Name, listSortSPnewWrappers[1].fieldName);
        System.assertNotEquals(lstAccountFromdataFactory[1].Name, listSortSPnewWrappers[2].fieldName);
    }

    @IsTest
    static void testDeleteRecord() {

        Integer amountRecords = 3;
        List<Account> listCreatedAccounts = TestDataFactory.createAccounts(amountRecords);
        insert listCreatedAccounts;

        Id necessaryIdToDelete = listCreatedAccounts[2].Id;

        Test.startTest();
        Account nessaryAccountBeforeDelete = [SELECT Id, IsDeleted
                                              FROM Account
                                              WHERE Id =:necessaryIdToDelete
                                              LIMIT 1];

        String recordType = 'Account';

        GetDataOffObjectsController.deleteRecord((String)necessaryIdToDelete, recordType );

        Account nessaryAccountAfterDelete = [SELECT Id, IsDeleted
                                             FROM Account
                                             WHERE Id =:necessaryIdToDelete
                                             ALL ROWS];
        Test.stopTest();

        System.assertEquals(amountRecords-1, [SELECT COUNT() FROM Account]);
        System.assertNotEquals(nessaryAccountBeforeDelete.IsDeleted, true);
        System.assertEquals(nessaryAccountAfterDelete.IsDeleted, true);
    }
}