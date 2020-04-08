/**
 * Created by mryzhkouskaya on 19.06.2019.
 */

public with sharing class Ex3_CustomLookupController {

    @AuraEnabled(cacheable=true)
    public static List<RecordsData> fetchRecords( String objectName, String filterField, String searchString ) {

        System.debug('In fetch records');
        List<RecordsData> recordsDataList = new List<RecordsData>();
        if(objectName.contains('__r')){
            objectName = objectName.substring(0,objectName.length()-1);
            objectName= objectName + 'c';

            List<String> setNamesCustomObjects = getSetNamesOfCustomObjects();
            if(!setNamesCustomObjects.contains(objectName)){
                objectName = objectName.substring(0,objectName.length()-3);
            }
        }

        try {
            String query = 'SELECT Id, ' + filterField+
                          ' FROM '+objectName+
                          ' WHERE '+filterField+
                          ' LIKE ' + '\'' + String.escapeSingleQuotes(searchString.trim()) + '%\'' + ' LIMIT 50000';

            for(SObject s : Database.query(query)){
                RecordsData recordsData = new RecordsData();
                recordsData.value = String.valueOf(s.get('id'));
                recordsData.label = String.valueOf(s.get(filterField));
                recordsDataList.add(recordsData);
            }
        } catch (Exception err) {
            if ( String.isNotBlank( err.getMessage() ) && err.getMessage().contains( 'error:' ) ) {
                throw new AuraHandledException(err.getMessage().split('error:')[1].split(':')[0] + '.');
            } else {
                throw new AuraHandledException(err.getMessage());
            }
        }

        return recordsDataList;
    }

    public static List<String> getSetNamesOfCustomObjects (){
        List<String> setNamesCustomObjects = new List<String>();
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
        {
            Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
            if(describeSObjectResultObj.isCustom())
            {
                String name = objTyp.getDescribe().getName();
                // Exclude all the unwanted Sobjects e.g. History, Share etc..
                if(!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                        !name.containsignorecase('share') && !name.containsignorecase('feed'))
                {
                    setNamesCustomObjects.add(name);
                }
            }
        }
        return setNamesCustomObjects;
    }

    @AuraEnabled(cacheable=true)
    public static String debugRecords( sObject objectData) {
        System.debug('objectData1 ' + objectData);
        return null;
    }

    public class RecordsData{
        @AuraEnabled
        public String label {get;set;}

        @AuraEnabled
        public String value {get;set;}

    }
}