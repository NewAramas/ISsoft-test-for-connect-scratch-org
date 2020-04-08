/**
 * Created by mryzhkouskaya on 08.07.2019.
 */
@IsTest
public with sharing class Ex5_GetFieldSetsTest {

    @IsTest
    static void testGetFieldsMemberRelevantArrFieldNames() {


        String objectName = 'Contact';
        List<String> listFieldNames = new List<String> {'Account ID','district','street','Ex5_You want buy', 'level' };

        Test.startTest();
        String jsonResult = Ex5_GetFieldSets.getFieldsMemberRelevantArrFieldNames(objectName, listFieldNames);

        List<Ex5_FieldSetMemberWrapper> listFields = (List<Ex5_FieldSetMemberWrapper>)JSON.deserialize(
                jsonResult,
                List<Ex5_FieldSetMemberWrapper>.class
        );
        Test.stopTest();

        System.assertEquals('AccountId', listFields[0].fieldAPIName);
        System.assertEquals('Account', listFields[0].relationShipNameForLookup);

        System.assertEquals('Level__c', listFields[1].fieldAPIName);
        System.assertEquals('PICKLIST', listFields[1].fieldType);
        System.assertNotEquals(null, listFields[1].pickListValues);

        System.assertEquals('Ex5_You_want_buy__c', listFields[2].fieldAPIName);
        System.assertEquals('MULTIPICKLIST', listFields[2].fieldType);
        System.assertNotEquals(null, listFields[2].pickListValues);

        System.assertEquals('Street__c', listFields[4].fieldAPIName);
        System.assertEquals('District__c', listFields[5].fieldAPIName);
        System.assertEquals('Street__c', listFields[5].nameNextPicklist);

    }

    @IsTest
    static void testGetFieldSetMemberRelevantNameOfFieldSets() {

        String objectName = 'Contact';
        String nameOfFieldSets = 'ex5_Contact_Field_Setting';

        Test.startTest();
        String jsonResult = Ex5_GetFieldSets.getFieldSetMemberRelevantNameOfFieldSets(objectName, nameOfFieldSets);

        List<Ex5_FieldSetMemberWrapper> listFields = (List<Ex5_FieldSetMemberWrapper>)JSON.deserialize(
                jsonResult,
                List<Ex5_FieldSetMemberWrapper>.class
        );
        Test.stopTest();

        System.assertEquals('Level__c', listFields[0].fieldAPIName);
        System.assertNotEquals(null, listFields[0].pickListValues);

        System.assertEquals('LastName',listFields[1].fieldAPIName);
        System.assertEquals('Street__c',listFields[2].fieldAPIName);

        System.assertEquals('AccountId',listFields[3].fieldAPIName);
        System.assertEquals('Account', listFields[3].relationShipNameForLookup);

        System.assertEquals('District__c',listFields[5].fieldAPIName);
        System.assertEquals('Street__c', listFields[5].nameNextPicklist);
    }

}