/**
 * Created by mryzhkouskaya on 17.05.2019.
 */

public with sharing class GetDataOffObjectsController {

    @AuraEnabled
    public static List<ObjectOrFieldNamesWrapper> getAllObjectNamesIntoPicklist() {

        List<ObjectOrFieldNamesWrapper> pickListOfObjectsWithAPINamesAndLabels = new List<ObjectOrFieldNamesWrapper>();

        for (Schema.SObjectType oneObject : Schema.getGlobalDescribe().values()) {
            String objectName = oneObject.getDescribe().getName();

            if (!oneObject.getDescribe().isCustomSetting() && oneObject.getDescribe().getRecordTypeInfos().size() > 0 &&
                    oneObject.getDescribe().isCreateable() &&
                    !objectName.containsIgnoreCase('history') &&
                    !objectName.containsIgnoreCase('tag') && !objectName.containsIgnoreCase('share') &&
                    !objectName.containsIgnoreCase('feed'))
            {
                ObjectOrFieldNamesWrapper objectWithApiNameAndLabel = new ObjectOrFieldNamesWrapper(
                        oneObject.getDescribe().getName(),
                        oneObject.getDescribe().getLabel(),
                        String.valueOf(oneObject.getDescribe().getSObjectType())
                );
                pickListOfObjectsWithAPINamesAndLabels.add(objectWithApiNameAndLabel);
            }
        }
        pickListOfObjectsWithAPINamesAndLabels.sort();
        return pickListOfObjectsWithAPINamesAndLabels;
    }

    @AuraEnabled
    public static String getFieldsNamesIntoPickList(String objectName){

        SObjectType objTyp = Schema.getGlobalDescribe().get(objectName);
        DescribeSObjectResult objDef = objTyp.getDescribe();
        Map<String, SObjectField> fields = objDef.fields.getMap();

        Set<String> fieldsSet = fields.keySet();
        List<ObjectOrFieldNamesWrapper> pickListOfObjectsWithAPINamesAndLabels = new List<ObjectOrFieldNamesWrapper>();

        for(String field: fieldsSet)
        {
            SObjectField SobjFields = fields.get(field);
            DescribeFieldResult selectedField = SobjFields.getDescribe();
            ObjectOrFieldNamesWrapper fieldWithApiNameAndLabelAndType = new ObjectOrFieldNamesWrapper(
                    selectedField.getName(),
                    selectedField.getLabel(),
                    String.valueOf(selectedField.getType()).toLowerCase()
            );
            pickListOfObjectsWithAPINamesAndLabels.add(fieldWithApiNameAndLabelAndType);
        }
        pickListOfObjectsWithAPINamesAndLabels.sort();
        String result = JSON.serialize(pickListOfObjectsWithAPINamesAndLabels);
        return result;
    }

    @AuraEnabled
    public static String getRecordsOfSelectedFields(String objectName, List<String> listSelectedFields){

        String query ='';
        String strFields = '';

        for(String fieldName : listSelectedFields ) {
            if(strFields == ''){
                strFields = fieldName;
            }else{
                strFields = strFields + ' , ' + fieldName;
            }
        }
        query = 'SELECT ' + strFields + ' FROM ' + objectName + ' ORDER BY ' + listSelectedFields[0] + ' LIMIT 10000';

        List<SObject> lstResult = new List<SObject>();
        String result = '[]';

        for(SObject s : Database.query(query)){
            lstResult.add(s);
        }
        if(lstResult.size() > 0) {
            result = JSON.serialize(lstResult);
        }
        return result;
    }

    @AuraEnabled
    public static List<SPnewWrapper> sortRecordsByFieldName(Map<String, String> mapIdToFieldvalue) {

        List<SPnewWrapper> sortList = new List<SPnewWrapper>();

        for (String item : mapIdToFieldvalue.keySet()) {
            SPnewWrapper objectBySPnewWrapper = new SPnewWrapper(
                    item,
                    mapIdToFieldvalue.get(item)
            );
            sortList.add(objectBySPnewWrapper);
        }
        SPComparator.sort(sortList, new SPanyObjectComparator());

        return sortList;
    }

    @AuraEnabled
    public static Map<String,String> deleteRecord(String recordId, String recordType) {

        Map<String,String> resultMap = new Map<String,String>();

        Id needId = (Id) recordId;
        String query = '';
        query = 'SELECT Id FROM ' + recordType + ' WHERE Id =:needId LIMIT 1';
        SObject objectToDelete = Database.query(query);

        try {
            delete objectToDelete;

            resultMap.put('status', 'success');
            resultMap.put('message', 'Record Deleted Successfully');
        }
        catch(DmlException dmx) {
            resultMap.put('status', 'error');
            resultMap.put('message',dmx.getMessage());
        }
        return resultMap;
    }
}