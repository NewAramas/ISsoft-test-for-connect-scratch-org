/**
 * Created by mryzhkouskaya on 10.06.2019.
 */

({
    setRecordsAndFieldsIntoTable : function(component, event, helper) {

        let objectName = event.getParam('arguments').attrObjectName;
        component.set("v.objectName", objectName);

        let fieldNamesForSelect = event.getParam('arguments').attrFieldNamesForSelect;
        component.set("v.fieldNamesForSelect", fieldNamesForSelect);

        let records = event.getParam('arguments').arrtRecords;
        if (records) {
            let recordSetObj = JSON.parse(records);
            component.set("v.tableRecords", recordSetObj);
        }

        let fields = event.getParam('arguments').attrFields;
        if (fields) {
            component.set("v.fieldSetValues", fields);
        }
        component.set("v.showTable", true);

    },

    deleteRecordById: function (component, event) {
        let toastEvent = $A.get('e.force:showToast');

        let action = component.get("c.deleteRecord");
        action.setParams({
            recordId: event.target.id,
            recordType: component.get("v.objectName")
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if(state === 'SUCCESS') {
                let dataMap = response.getReturnValue();
                if(dataMap.status === 'success') {
                    // alert(dataMap.message);
                    toastEvent.setParams({
                        'title': 'Success!',
                        'type': 'success',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();
                    let records = component.get("v.tableRecords");
                    records = records.filter(x => x.Id !== event.target.id);
                    component.set("v.tableRecords", records);
                }
                else if(dataMap.status === 'error') {
                    toastEvent.setParams({
                        'title': 'Error!',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': dataMap.message
                    });
                    toastEvent.fire();
                }
            }
            else {
                alert('Error in getting data');
            }
        });
        $A.enqueueAction(action);
    },

    createNewRecord : function(component, event, helper) {

        let recordType = component.get("v.objectName");

        ////////for lightning////////////////

        // let createRecordEvent = $A.get("e.force:createRecord");
        // if (createRecordEvent) {
        //     createRecordEvent.setParams({
        //         "entityApiName": recordType,
        //         "navigationLocation": "LOOKUP",
        //         "panelOnDestroyCallback": function (event) {
        //         }
        //     });
        //     createRecordEvent.fire();
        // } else {
        // }

        ////////for visualforce////////////////

        component.set("v.showHideModal", true);
        component.set("v.showCreateWindow", true);
    },

    editRecordById: function (component, event, helper) {

        ////////for lightning////////////////

        // let editEvent = $A.get("e.force:editRecord");

        // if (editEven !== undefined) {

        //     editEvent.setParams({
        //         recordId: event.target.id,
        //     });
        //     editEvent.fire();
        // } else {
        // }

        ////////////for visualforce////////////////

        component.set("v.recordId",event.target.id);
        component.set("v.showHideModal",true);
        component.set("v.showEditWindow",true);
    },
    updateEditRecords: function(component, event, helper){

        let action = component.get("c.getRecordsOfSelectedFields");
        action.setParams({
            objectName: component.get("v.objectName"),
            listSelectedFields: component.get("v.fieldNamesForSelect"),
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let recordSetObj = JSON.parse(response.getReturnValue());
                component.set("v.tableRecords", recordSetObj);
            }
        });
        $A.enqueueAction(action);
    },

    viewRecordById: function(component, event){
        component.set("v.recordId",event.target.id);
        component.set("v.showHideModal",true);
        component.set("v.showViewWindow",true);
    },

    closeModel: function(component, event, helper) {
        component.set("v.showHideModal", false);
        component.set("v.showViewWindow",false);
        component.set("v.showEditWindow",false);
        component.set("v.showCreateWindow",false);
    }
});