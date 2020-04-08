/**
 * Created by mryzhkouskaya on 04.06.2019.
 */

({
    showSpinner: function (component) {
        let spinnerMain = component.find("Spinner");
        $A.util.removeClass(spinnerMain, "slds-hide");
    },

    hideSpinner: function (component) {
        let spinnerMain = component.find("Spinner");
        $A.util.addClass(spinnerMain, "slds-hide");
    },

    handleCmpObjectChoiceEvent: function (component, event, helper) {
        helper = this;
        helper.showSpinner(component);
        component.set("v.showSpinner", true);

        let action = component.get("c.getFieldsNamesIntoPickList");
        action.setParams({
            objectName: event.getParam("objectName")
        });
        component.set("v.attrObjectName", event.getParam("objectName"));

        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {

                helper.hideSpinner(component);
                component.set("v.showSpinner", false);
                
                let listFields = response.getReturnValue();
                component.set("v.attrListFieldObjects", listFields);

                let objCompChoiceObject = component.find('compChoiceField');
                objCompChoiceObject.getFieldNamesFromMainCmp(listFields);

            }
        });
        $A.enqueueAction(action);

    },

    handleCmpSelectedFieldsEvent: function (component, event, helper) {

        helper = this;
        helper.showSpinner(component);
        component.set("v.showSpinner", true);

        let listSelectedAPINamesOfFields = event.getParam("attributeSelectedFields");
        let setSelectedAPINamesOfFields = new Set(listSelectedAPINamesOfFields);
        let listSelectedFieldObjects = [];
        let listFieldObjects = JSON.parse(component.get("v.attrListFieldObjects"));

        listFieldObjects.forEach(function(field){
            if(setSelectedAPINamesOfFields.has(field.APIName)){
                listSelectedFieldObjects.push(field);
            }
        });

        let action = component.get("c.getRecordsOfSelectedFields");
        action.setParams({
            objectName: component.get("v.attrObjectName"),
            listSelectedFields: listSelectedAPINamesOfFields
        });

        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {

                component.set("v.showSpinner", false);
                helper.hideSpinner(component);

                let objCompChoiceObject = component.find('compTableWithSelectedFields');
                objCompChoiceObject.transferRecordsAndFieldsMethod(
                    response.getReturnValue(),
                    listSelectedFieldObjects,
                    component.get("v.attrObjectName"),
                    listSelectedAPINamesOfFields
                );
            }
        });
        $A.enqueueAction(action);
    }
});