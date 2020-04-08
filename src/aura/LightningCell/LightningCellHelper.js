/**
 * Created by mryzhkouskaya on 24.05.2019.
 */

({
    doInit : function(component, event, helper) {

        let record = component.get("v.record");
        let field = component.get("v.field");
        component.set("v.cellValue", record[field.APIName]);
    }
});