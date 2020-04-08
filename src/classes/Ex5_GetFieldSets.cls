/**
 * Created by mryzhkouskaya on 24.06.2019.
 */

public with sharing class Ex5_GetFieldSets {

    @AuraEnabled
    public static String getFieldsetNamesOfSelectedObject(String objectName) {

        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe();
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectName);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

        Map<String, Schema.FieldSet> mapfieldSets = DescribeSObjectResultObj.FieldSets.getMap();
        Set<String> setStrings = mapfieldSets.keySet();
        return JSON.serialize(setStrings);
    }


    @AuraEnabled
    public static String getFieldsMemberRelevantListFieldNames(String objectName, List<String> listFieldNames) {

        Map<String, Schema.SObjectField> mapFieldLabelToField = Schema.getGlobalDescribe().get(objectName).getDescribe()
                .fields.getMap();

        InnerWrappToReturn innerWrappToReturn;
        List<String> listNamesControllingFields = new List<String>();
        List<Ex5_FieldSetMemberWrapper> listFieldsWithDependency = new List<Ex5_FieldSetMemberWrapper>();
        List<Ex5_FieldSetMemberWrapper> listFieldsFromWrapper = new List<Ex5_FieldSetMemberWrapper>();
        Schema.SObjectType sObjectExampler = Schema.getGlobalDescribe().get(objectName);

        if(mapFieldLabelToField != null && listFieldNames != null){
            for (String field : mapFieldLabelToField.keySet()) {
                for (String fieldNameFromInput : listFieldNames) {

                    String fieldFromDataModel = mapFieldLabelToField.get(field).getDescribe().getLocalName();

                    if (fieldFromDataModel == fieldNameFromInput) {
                        Ex5_FieldSetMemberWrapper wrapper = new Ex5_FieldSetMemberWrapper();

                        wrapper.isRequired = !mapFieldLabelToField.get(field).getDescribe().isNillable();
                        wrapper.fieldType = String.valueOf(mapFieldLabelToField.get(field).getDescribe().getType());
                        wrapper.fieldLabel = mapFieldLabelToField.get(field).getDescribe().getLabel();
                        wrapper.fieldAPIName = mapFieldLabelToField.get(field).getDescribe().getLocalName();
                        String fieldName = wrapper.fieldAPIName;
                        String fieldType = wrapper.fieldType;
                        Schema.sObjectField controlToken = mapFieldLabelToField.get(fieldName).getDescribe()
                                .getController();

                        innerWrappToReturn = setPicklistOrReferenceValues(wrapper, controlToken, sObjectExampler,
                                fieldName, fieldType, listNamesControllingFields, listFieldsWithDependency);

                        listFieldsFromWrapper.add(innerWrappToReturn.wrapper);
                        listNamesControllingFields = innerWrappToReturn.listNamesControllingFields;
                        listFieldsWithDependency = innerWrappToReturn.listFieldsWithDependency;
                    }
                }
            }
        }

        // order dependent picklist and set attribute equals name of Next Picklist
        listFieldsFromWrapper = setDoubly_DependentLinkedListData(
                listFieldsFromWrapper,
                innerWrappToReturn.listFieldsWithDependency,
                innerWrappToReturn.listNamesControllingFields);

        return JSON.serialize(listFieldsFromWrapper);
    }


    @AuraEnabled
    public static String getFieldSetMemberRelevantNameOfFieldSets(String objectName, String nameOfFieldSets){

        List<String> listNamesControllingFields = new List<String>();
        List<Ex5_FieldSetMemberWrapper> listFieldsWithDependency = new List<Ex5_FieldSetMemberWrapper>();

//        String objectName = 'Contact';
//        String nameOfFieldSets = 'ex5_Contact_Field_Setting';
//        level,district,street,first name,Ex5_You want buy
//        level__c,district__c,street__cEx5_You_want_buy__c
        //Account ID,level,district,street,first name,Ex5_You want buy
        List<Ex5_FieldSetMemberWrapper> listFieldsFromWrapper = new List<Ex5_FieldSetMemberWrapper>();
        InnerWrappToReturn innerWrappToReturn;

        Schema.SObjectType sObjectExampler = Schema.getGlobalDescribe().get(objectName);
        if (sObjectExampler != null) {
            for (Schema.FieldSetMember fieldMember : sObjectExampler.getDescribe().fieldSets.getMap().get(nameOfFieldSets)
                    .getFields()) {

                Ex5_FieldSetMemberWrapper wrapper = new Ex5_FieldSetMemberWrapper();

                wrapper.fieldType = String.valueOf(fieldMember.getType());
                wrapper.fieldLabel = fieldMember.getLabel();
                wrapper.fieldAPIName = fieldMember.getFieldPath();

                if (!fieldMember.getRequired()) {
                    Map<String, Schema.SObjectField> mapFieldLabelToField = sObjectExampler.getDescribe().fields.getMap();
                    wrapper.isRequired = !(mapFieldLabelToField.get(fieldMember.getFieldPath()).getDescribe().isNillable());
                } else {
                    wrapper.isRequired = fieldMember.getRequired();
                }

                Schema.sObjectField controlToken = sObjectExampler.getDescribe().fields.getMap().get(fieldMember
                        .getFieldPath()).getDescribe().getController();

                String fieldName = fieldMember.getFieldPath();
                String fieldType = String.valueOf(fieldMember.getType());

                innerWrappToReturn = setPicklistOrReferenceValues(wrapper, controlToken, sObjectExampler, fieldName,
                        fieldType, listNamesControllingFields, listFieldsWithDependency);

                listFieldsFromWrapper.add(innerWrappToReturn.wrapper);
                listNamesControllingFields = innerWrappToReturn.listNamesControllingFields;
                listFieldsWithDependency = innerWrappToReturn.listFieldsWithDependency;
            }
        }

        // order dependent picklist and set attribute equals name of Next Picklist
        listFieldsFromWrapper = setDoubly_DependentLinkedListData(listFieldsFromWrapper,
                innerWrappToReturn.listFieldsWithDependency,
                innerWrappToReturn.listNamesControllingFields);

        return JSON.serialize(listFieldsFromWrapper);
    }

    private class InnerWrappToReturn{
        List<Ex5_FieldSetMemberWrapper> listFieldsWithDependency;
        List<String> listNamesControllingFields;
        Ex5_FieldSetMemberWrapper wrapper;
    }

    private static InnerWrappToReturn setPicklistOrReferenceValues(
            Ex5_FieldSetMemberWrapper wrapper, Schema.sObjectField controlToken, Schema.SObjectType sObjectExampler,
            String fieldName, String fieldType, List<String> listNamesControllingFields,
            List<Ex5_FieldSetMemberWrapper> listFieldsWithDependency
    ) {
        InnerWrappToReturn innerWrappToReturn = new InnerWrappToReturn();

        if (wrapper.fieldType.equals('PICKLIST') || wrapper.fieldType.equals('MULTIPICKLIST')) {

            if (controlToken != null &  wrapper.fieldType.equals('PICKLIST')) {

                List<String> listFieldDependency = new List<String>();
                String jsonControllingFieldName = JSON.serialize(''+controlToken);

                listFieldsWithDependency.add(wrapper);
                String stringControllingFieldName = (String)System.JSON.deserialize(
                        jsonControllingFieldName, String.class
                );
                listNamesControllingFields.add(stringControllingFieldName);

                wrapper.nameControllerField = stringControllingFieldName;
                innerWrappToReturn.listFieldsWithDependency = listFieldsWithDependency;
                innerWrappToReturn.listNamesControllingFields = listNamesControllingFields;
                innerWrappToReturn.wrapper = wrapper;

                return innerWrappToReturn;

            } else {
                wrapper.nameControllerField = null;
                wrapper.pickListValues = sObjectExampler.getDescribe().fields.getMap()
                        .get(fieldName).getDescribe().getPicklistValues();
            }
        }

        if (fieldType.equals('REFERENCE')) {
            wrapper.relationShipNameForLookup = sObjectExampler.getDescribe().fields.getMap()
                    .get(fieldName).getDescribe().getRelationshipName();
        }
        innerWrappToReturn.listFieldsWithDependency = listFieldsWithDependency;
        innerWrappToReturn.listNamesControllingFields = listNamesControllingFields;
        innerWrappToReturn.wrapper = wrapper;

        return innerWrappToReturn;
    }
/**
* Describe
* @param listWithDependentPicklist -
* @return
* */
    private static List<Ex5_FieldSetMemberWrapper> setDoubly_DependentLinkedListData(
            List<Ex5_FieldSetMemberWrapper> listFieldsFromWrapper,
            List<Ex5_FieldSetMemberWrapper> listWithDependentPicklist, List<String> listNamesControllingFields){

        //refactor(add first of dependent picklists) List of fields With Field Dependence
        listWithDependentPicklist = refactorListWithFieldDependence(
                listFieldsFromWrapper, listWithDependentPicklist, listNamesControllingFields);

        //find the last fieldMember of picklist
        Ex5_FieldSetMemberWrapper theLastDependentField;
        theLastDependentField = findLastDependentField(listWithDependentPicklist, theLastDependentField);

        //set next picklist field (order fields with dependency in list)
        listWithDependentPicklist = orderListWithDependentFields(listWithDependentPicklist, theLastDependentField);

        listFieldsFromWrapper.addAll(listWithDependentPicklist);

        return listFieldsFromWrapper;
    }

    private static List<Ex5_FieldSetMemberWrapper>  refactorListWithFieldDependence(
            List<Ex5_FieldSetMemberWrapper> listFieldsFromWrapper,
            List<Ex5_FieldSetMemberWrapper> listWithDependentPicklist, List<String> listNamesControllingFields){

            if (listFieldsFromWrapper != null){
                for (Integer i = 0; i < listFieldsFromWrapper.size(); i++) {
                    Ex5_FieldSetMemberWrapper field = listFieldsFromWrapper.get(i);

                    if (listNamesControllingFields.contains(field.fieldAPIName)) {
                        listWithDependentPicklist.add(field);
                        listFieldsFromWrapper.remove(i);
                        i--;
                    }
                }
            }

        return listWithDependentPicklist;
    }

    private static Ex5_FieldSetMemberWrapper  findLastDependentField(
            List<Ex5_FieldSetMemberWrapper> listWithDependentPicklist, Ex5_FieldSetMemberWrapper theLastDependentField){

        Boolean flag = true;
        for (Ex5_FieldSetMemberWrapper field : listWithDependentPicklist) {
            flag = true;

            for (Ex5_FieldSetMemberWrapper field2 : listWithDependentPicklist) {

                if (field.fieldAPIName.equals(field2.nameControllerField)) {
                    flag = false;
                }
            }
            if (flag) {
                theLastDependentField = field;
            }
        }
        return theLastDependentField;
    }

    private static List<Ex5_FieldSetMemberWrapper>  orderListWithDependentFields(
            List<Ex5_FieldSetMemberWrapper> listWithDependentPicklist, Ex5_FieldSetMemberWrapper theLastDependentField){

        for (Integer i = 0; i < listWithDependentPicklist.size(); i++) {
            Ex5_FieldSetMemberWrapper field = listWithDependentPicklist[i];
            if (field.fieldAPIName.equals(theLastDependentField.nameControllerField)) {
                field.nameNextPicklist = theLastDependentField.fieldAPIName;
                theLastDependentField = field;
                i = 0;
            }
        }
        return listWithDependentPicklist;
    }

/**
* Describe do insert record, send email to chatter, call sendMailMethod
* @param objectData - object with all selected values
* @return sMessage - success or error message
* */
    @AuraEnabled
    public static String doUpsertObjects(SObject objectData, String sObjectType, String email){

        System.debug('in upsert'+ objectData);
        insert objectData;

        String sMessage;
        try{
            String userID = UserInfo.getUserId();
            String userName = UserInfo.getName();

            String body = 'Hello,This is an automated email from Salesforce-communities.com. '+ sObjectType +
                    ' was created by ' + userName + '. The link to the ' + sObjectType +
                    ' is here https://aramas-dev-ed.lightning.force.com/lightning/r/'+objectData.Id +'/view';

            FeedItem post = new FeedItem();
            post.ParentId = userID;
            post.Body = body;
            insert post;
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
            return sMessage;
        }

        sMessage = sendMailMethod(email, sObjectType, objectData.Id);
        return sMessage;
    }

/**
* Describe send email
* @param
* @return sMessage - success or error message
* */
    @AuraEnabled
    public static String sendMailMethod(String email, String sObjectType, String objectId ){

        String sMessage='';
        try{
            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            List<String> sendTo = new List<String>();
            String toAddresses = email;
            sendTo.add(toAddresses);

            mail.setToAddresses(sendTo);
            mail.setHtmlBody('Hello,This is an automated email from Salesforce-communities.com.'+ sObjectType +
                    ' was created. The link to the ' + sObjectType +
                    ' is here https://aramas-dev-ed.lightning.force.com/lightning/r/'+objectId +'/view');
            mails.add(mail);
            Messaging.sendEmail(mails);
            sMessage='Success';
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
        }
        return sMessage;
        //margushanew@gmail.com
    }

}