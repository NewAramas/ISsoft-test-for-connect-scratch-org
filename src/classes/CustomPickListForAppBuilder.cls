/**
 * Created by mryzhkouskaya on 27.08.2019.
 */

global class CustomPickListForAppBuilder extends VisualEditor.DynamicPickList{

        VisualEditor.DesignTimePageContext context;

        global CustomPickListForAppBuilder(VisualEditor.DesignTimePageContext context) {
        this.context = context;
    }
    global override VisualEditor.DataRow getDefaultValue(){

//        return null;
        return new VisualEditor.DataRow('None', 'None');
    }

    global override VisualEditor.DynamicPickListRows getValues(){

        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();

        for(String ss1: schemaMap.keySet()){
            Schema.SObjectType objToken = schemaMap.get(ss1);
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            String objectName = objDescribe.getName();
            if (!objDescribe.isCustomSetting() &&
                    !objectName.contains('__c')&&
                    objDescribe.isCreateable() &&
                    !objectName.containsIgnoreCase('history') &&
                    !objectName.containsIgnoreCase('tag') && !objectName.containsIgnoreCase('share') &&
                    !objectName.containsIgnoreCase('feed'))
            {
                VisualEditor.DataRow picklistRowValue = new VisualEditor.DataRow(objDescribe.getLabel(), objDescribe.getName());
                picklistValues.addRow(picklistRowValue);
            }
        }

        return picklistValues;
    }
//    global override VisualEditor.DynamicPickListRows getValues() {
//        String currentPageObjectName = context.entityName;
//        String fieldName = 'Industry';
//        VisualEditor.DynamicPickListRows  picklistValues = new VisualEditor.DynamicPickListRows();
//        Map<String, Schema.SObjectField> currPageObjectfieldsMap = Schema.getGlobalDescribe().get(currentPageObjectName).getDescribe().fields.getMap();
//
//        for(Schema.SObjectField field : currPageObjectfieldsMap.values())
//        {
//            Schema.DescribeFieldResult descField = field.getDescribe();
//            if(String.ValueOf(descField.type)=='PICKLIST' && descField.getName()==fieldName)
//            {
//                List<Schema.PicklistEntry> valuesList = new List<Schema.PicklistEntry>();
//                valuesList = descField.getPicklistValues();
//
//                for(Schema.PicklistEntry value : valuesList)
//                {
//                    VisualEditor.DataRow dataRow = new VisualEditor.DataRow(value.getLabel(), value.getValue());
//                    picklistValues.addRow(dataRow);
//                }
//                break;
//            }
//
//        }
//
//        return picklistValues;
//    }
}