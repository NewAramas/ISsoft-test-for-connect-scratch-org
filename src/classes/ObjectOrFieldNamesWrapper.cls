/**
 * Created by mryzhkouskaya on 21.05.2019.
 */

public with sharing class ObjectOrFieldNamesWrapper implements Comparable{

    @AuraEnabled
    public String  APIName;
    @AuraEnabled
    public String  APILabel;
    @AuraEnabled
    public String  type;

    public ObjectOrFieldNamesWrapper(String APIName, String APILabel, String type){
        this.APIName = APIName;
        this.APILabel = APILabel;
        this.type = type;
    }

    public Integer compareTo(Object oneObject) {
        ObjectOrFieldNamesWrapper oneObjectTObjectNamesWrapper = (ObjectOrFieldNamesWrapper)oneObject;
        if (APILabel == oneObjectTObjectNamesWrapper.APILabel) return 0;
        if(APILabel > oneObjectTObjectNamesWrapper.APILabel) return 1;
        return -1;
    }
    
}