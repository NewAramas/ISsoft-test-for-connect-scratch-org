/**
 * Created by mryzhkouskaya on 29.05.2019.
 */

public with sharing class SPnewWrapper {

    @AuraEnabled
    public String  fieldName;

    @AuraEnabled
    public String  id;

    public SPnewWrapper(String id, String fieldName){
        this.fieldName = fieldName;
        this.id = id;
    }
}