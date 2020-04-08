/**
 * Created by mryzhkouskaya on 10.07.2019.
 */


({
    init: function(component, event, helper) {

        console.log('in init ex5');
        console.log('email '+ component.get('v.email'));

        //change all data dependent of app builder
        let objectNameForApp = component.get('v.ObjectNameForApp');
        let fieldNameForApp = component.get('v.FieldNameForApp');
        let fieldSetNameForApp = component.get('v.FieldSetNameForApp');

        //change sobjectType from app Builder
        let sObj = {};
        sObj.sobjectType = objectNameForApp;
        component.set('v.sObjectInfo', sObj);

        //get fields
        if ((fieldNameForApp !== undefined && fieldNameForApp !== null) && (fieldSetNameForApp === null || fieldSetNameForApp === '')
        ){
            let listFieldNameForApp = fieldNameForApp.split(',');
            let actionGetFields = component.get("c.getFieldsMemberRelevantListFieldNames");
            actionGetFields.setParams({
                'objectName': objectNameForApp,
                'listFieldNames': listFieldNameForApp
            });
            actionGetFields.setCallback(this, function (response) {
                let state = response.getState();
                console.log('state '+state);
                if (state === "SUCCESS") {
                    let resultOfResponse = JSON.parse(response.getReturnValue());
                    component.set('v.fieldSets', resultOfResponse);

                    helper.createForm(component, event, helper);

                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    let errorMessage = response.getError()[0].message;

                    toastEvent.setParams({
                        "title": "Error",
                        "message": "The data was not enter or incorrect. Error: " + errorMessage,
                        "type": "error"
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(actionGetFields);
        }


        // get fieldSets
        if (fieldSetNameForApp !== undefined && fieldSetNameForApp !== null && fieldNameForApp === null || fieldNameForApp === '') {
            let actionGetFieldSets = component.get("c.getFieldSetMemberRelevantNameOfFieldSets");
            actionGetFieldSets.setParams({
                'objectName': objectNameForApp,
                'nameOfFieldSets': fieldSetNameForApp
            });
            actionGetFieldSets.setCallback(this, function (response) {
                let state = response.getState();
                if (state === "SUCCESS") {
                    let resultOfResponse = JSON.parse(response.getReturnValue());
                    component.set('v.fieldSets', resultOfResponse);

                    helper.createForm(component, event, helper);

                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    let errorMessage = response.getError()[0].message;

                    toastEvent.setParams({
                        "title": "Error",
                        "message": "The data was not enter or incorrect. Error: " + errorMessage,
                        "type": "error"
                    });
                    toastEvent.fire();
                }
            });
            $A.enqueueAction(actionGetFieldSets);
        }

        //change position from data of app builder
        let position = component.get('v.PositionForApp');
        if (position === '2 columns') {
            let nnn = component.find('divForLayoutId');
            $A.util.addClass(nnn, 'slds-wrap');
            $A.util.removeClass(nnn, 'slds-grid_vertical');
        }
    },


    saveForm : function(component, event, helper) {
        helper.checkValidation(component, event, helper);
    },

    clearForm : function(component, event, helper) {
        helper.clearForm(component, event, helper);
    },

    handleComponentEventFromEx3cmp : function(component, event, helper) {

        let selectID = event.getParam("selectID");
        let fieldNameOfToSet = event.getParam("fieldNameOfToSetObject");

        let record = component.get('v.sObjectInfo');
        record[fieldNameOfToSet] = selectID;
        component.set('v.sObjectInfo', record);
    },


    handleComponentEventFromEx2cmp : function(component, event) {
        let object = event.getParam("objWithSelectedValues");
        let record = component.get('v.sObjectInfo');

        for (let fieldNameOfToSet in object){
            record[fieldNameOfToSet] = object[fieldNameOfToSet];
        }

        component.set('v.sObjectInfo', record);
    }
})