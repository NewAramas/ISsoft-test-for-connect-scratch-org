/**
 * Created by mryzhkouskaya on 17.10.2019.
 */
({

    handleSelectObject: function (component, helper) {

        component.set('v.selectedTypeCreationObject', 'None');
        component.set('v.flagShowInputFields', false);
        component.set('v.flagShowComboboxWithFieldsSets', false);
        component.set('v.disabledComboboxWithTypeCreation', false);
    },

    handleSelectTypeCreationRecord: function (component, helper) {

        if (component.get('v.selectedTypeCreationObject') === 'List_of_fields') {
            component.set('v.flagShowInputFields', true);
            component.set('v.flagShowComboboxWithFieldsSets', false);
        } else {
            if (component.get('v.selectedTypeCreationObject') === 'FieldSet') {
                component.set('v.flagShowInputFields', false);

                let action = component.get("c.getFieldsetNamesOfSelectedObject");
                action.setParams({
                    'objectName': component.get('v.selectedObjectName')
                });
                action.setCallback(this, function (response) {
                    let state = response.getState();
                    if (state === "SUCCESS") {
                        let resultOfResponse = JSON.parse(response.getReturnValue());
                        if(resultOfResponse.length !== 0){
                            component.set('v.flagShowComboboxWithFieldsSets', true);
                            let fields11WithLabelAndValue = [];

                            resultOfResponse.forEach(function (item) {
                                fields11WithLabelAndValue.push({
                                    label: item,
                                    value: item
                                });
                            });
                            component.set('v.optionsOfNamesOfFieldSets', fields11WithLabelAndValue);
                        }else{
                            let toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                "title": "Error",
                                "message": "There is no fieldSet for this object " ,
                                "type": "error"
                            });
                            toastEvent.fire();
                        }
                    }
                });
                $A.enqueueAction(action);
            }else{
                component.set('v.flagShowInputFields', false);
                component.set('v.flagShowComboboxWithFieldsSets', false);
            }
        }
    },


    sendHelper: function(component, getEmail) {
        let action = component.get("c.sendMailMethod");
        action.setParams({
            'email': getEmail,
            'sObjectType' : component.get('v.selectedObjectName')
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let storeResponse = response.getReturnValue();
                // component.set("v.mailStatus", true);
            }
        });
        $A.enqueueAction(action);
    },

})