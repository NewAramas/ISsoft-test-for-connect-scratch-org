/**
 * Created by mryzhkouskaya on 21.06.2019.
 */

public with sharing class Ex4_MultiSelectLookupCtrl {
    @AuraEnabled
    public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, List<sObject> ExcludeitemsList) {

        String searchKey = '%' + searchKeyWord + '%';
//        List < sObject > returnList = new List < sObject > ();

        List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }

        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);

        return lstOfRecords;
    }
}