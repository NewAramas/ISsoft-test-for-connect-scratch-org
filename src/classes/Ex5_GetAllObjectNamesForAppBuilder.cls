/**
 * Created by mryzhkouskaya on 27.08.2019.
 */


global class Ex5_GetAllObjectNamesForAppBuilder extends VisualEditor.DynamicPickList {

    VisualEditor.DesignTimePageContext context;

    global Ex5_GetAllObjectNamesForAppBuilder(VisualEditor.DesignTimePageContext context) {
        this.context = context;
    }
    global override VisualEditor.DataRow getDefaultValue() {
        return null;
    }

    global override VisualEditor.DynamicPickListRows getValues() {

        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        VisualEditor.DynamicPickListRows picklistValues = new VisualEditor.DynamicPickListRows();

        for (String ss1 : schemaMap.keySet()) {
            Schema.SObjectType objToken = schemaMap.get(ss1);
            Schema.DescribeSObjectResult objDescribe = objToken.getDescribe();
            String objectName = objDescribe.getName();
            if (!objDescribe.isCustomSetting() &&
                    !objectName.contains('__c') &&
                    objDescribe.isCreateable() &&
                    !objectName.containsIgnoreCase('history') &&
                    !objectName.containsIgnoreCase('tag') && !objectName.containsIgnoreCase('share') &&
                    !objectName.containsIgnoreCase('feed')) {
                VisualEditor.DataRow picklistRowValue = new VisualEditor.DataRow(objDescribe.getLabel(), objDescribe.getName());
                picklistValues.addRow(picklistRowValue);
            }
        }
        return picklistValues;
    }
}