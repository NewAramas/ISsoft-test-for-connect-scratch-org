/**
 * Created by mryzhkouskaya on 10.07.2019.
 */
({
    configMap: {
        'anytype': { componentDef: 'lightning:input', attributes: {} },
        'base64': { componentDef: 'lightning:input', attributes: {} },
        'boolean': {componentDef: 'lightning:input', attributes: { type: 'checkbox'} },
        'combobox': { componentDef: 'lightning:input', attributes: {} },
        'currency': { componentDef: 'lightning:input', attributes: {} },
        'datacategorygroupreference': { componentDef: 'lightning:input', attributes: {} },
        'date': { componentDef: 'lightning:input',  attributes: { type: 'date'}},
        'datetime': { componentDef: 'lightning:input', attributes: {type: 'datetime'} },
        'double': { componentDef: 'lightning:input', attributes: {type: 'number'}},
        'email': { componentDef: 'lightning:input', attributes: {type: 'email'} },
        'encryptedstring': { componentDef: 'lightning:input', attributes: {} },
        'integer': { componentDef: 'lightning:input', attributes: {type: 'number'} },
        'multipicklist': { componentDef: 'lightning:dualListbox', attributes: { "sourceLabel": "Available Options",
                                                                        "selectedLabel": "Selected Options",
                                                                        "readOnly": false} },
        'percent': { componentDef: 'lightning:input', attributes: {type: 'number'} },
        'phone': { componentDef: 'lightning:input', attributes: {type:'tel'} },
        'picklist': { componentDef: 'lightning:combobox', attributes: {  } },
        'reference': { componentDef: 'c:Ex3_CustomLookup' , attributes: { 'aura:id':'cmpWithLookup'} },
        'string': { componentDef: 'lightning:input' , attributes: {} },
        'textarea': { componentDef: 'lightning:textarea', attributes: {} },
        'time': { componentDef: 'lightning:input', attributes: {type: 'time'} },
        'url': { componentDef: 'lightning:input', attributes: {type: 'url'} }
    },


    createForm: function(component,event, helper) {

        console.log('in  create ex5');

        let fieldSets = component.get('v.fieldSets');
        // let fieldSets = JSON.parse(component.get('v.fieldSets'));
        let inputDesc = [];
        let listFieldsWithDependency = [];

        for (let i = 0; i < fieldSets.length; i++) {

            let field = fieldSets[i];
            let type = field.fieldType.toLowerCase();

            if (type === 'picklist' && (field.nameControllerField != null || field.nameNextPicklist !=null)) {

                listFieldsWithDependency.push(field);
                fieldSets.splice(i, 1);
                i--;
            }
        }

        //for create dependency picklists
        inputDesc.push(["c:Ex2_DynDependentPicklist",{
            fieldsdWithDependency : listFieldsWithDependency,
        }]);


        for (let i = 0; i < fieldSets.length; i++) {

            let field = fieldSets[i];
            // console.log('field',field);
            let type = field.fieldType.toLowerCase();
            let configTemplate = this.configMap[type];
            let config = JSON.parse(JSON.stringify(configTemplate));

            if( type === 'multipicklist' || type === 'picklist'){

                let options = [];
                 if(type === 'picklist'){
                     options.push({
                         value: null,
                         label: '--None--'
                     });
                 }

                 for (let k = 0; k < field.pickListValues.length; k++) {
                    options.push({
                        value: field.pickListValues[k].value,
                        label: field.pickListValues[k].label
                    });
                }
                config.attributes.options = options;
            }

            ////////////for lookup///////
            config.attributes.objectName = field.relationShipNameForLookup;
            config.attributes.fieldNameOfToSetObject = field.fieldAPIName;
            //

            config.attributes.label = field.fieldLabel;
            config.attributes.required = field.isRequired;
            config.attributes.value = component.getReference('v.sObjectInfo.' + field.fieldAPIName);
            config.attributes.fieldPath = field.fieldAPIName;
            config.attributes['aura:id'] = i+1;

            inputDesc.push([
                config.componentDef,
                config.attributes
            ]);
        }

        console.log('inputDEcs', inputDesc);

        // // for create multilookup
        // inputDesc.push(["c:Ex4_MultiSelectLookupCmp",{
        //     objectAPIName : "Account",
        //     IconName : "standard:contact",
        //     label : "Account Name",
        // }]);
        // $A.createComponents(inputDesc, function (components) {
        //     component.set('v.theForm', components);
        // });

        $A.createComponents(
            inputDesc,
            function(components, status, errorMessage){

                if (status === "SUCCESS") {
                    component.set('v.theForm', components);
                }
                else if (status === "INCOMPLETE") {
                    console.log("WWW No response from server or client is offline.")
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error WWWW: " , errorMessage);
                    // Show error message
                }
            }
        );
    },

    checkValidation : function(component, event, helper) {
        console.log('in check validation');

        let resultOfCheckvalidationCustomCMP = true;
        let flagValidOrNotRecord = 'valid';

        component.get('v.theForm').forEach(function(key){

            //call checkValidation methods
            // of required fields on custom components
            if(!key.toString().includes('SecureComponentRef')){
               resultOfCheckvalidationCustomCMP =  key.checkValidationOnRequiredFields();

            }else if(!key.get("v.validity").valid) {
                //check validation of required fields on other fields
                key.showHelpMessageIfInvalid();
                resultOfCheckvalidationCustomCMP = false;
            }
            if(!resultOfCheckvalidationCustomCMP){
                flagValidOrNotRecord = 'not valid';
            }
        });

        // if all fields are valid call upsert method
        if(flagValidOrNotRecord !== 'not valid'){
            let self = this;
            self.onUpsertObject(component, event, helper);
        }

    },

    onUpsertObject : function(component, event, helper) {
        console.log('### in upsert');

        let upsertObject = component.get('c.doUpsertObjects');
        upsertObject.setParams({
            'objectData' :  component.get('v.sObjectInfo'),
            'sObjectType' : component.get('v.ObjectNameForApp'),
            'email' : component.get('v.email')
        });
        upsertObject.setCallback(this,
            function(response) {
                let state = response.getState();
                let toastEvent = $A.get("e.force:showToast");
                if ( state === "SUCCESS") {

                    let self = this;
                    self.clearForm(component, event, helper);

                    toastEvent.setParams({
                        "title": "Success!",
                        "message": "The record has been upserted successfully.",
                        "type": "success"
                    });

                    toastEvent.fire();

                    $A.get('e.force:refreshView').fire();
                } else {
                    console.log('In error');
                    if (state === "ERROR") {
                        let errorMessage = response.getError()[0].message;

                        toastEvent.setParams({
                            "title": "Error",
                            "message": "The record was not saved. Error: " + errorMessage,
                            "type": "error"
                        });

                        toastEvent.fire();
                    }
                }
            }
        );
        $A.enqueueAction(upsertObject);
    },

    clearForm : function(component, event, helper) {
        console.log('in clear form');

        // clear selectedData in main cmp
        let sObj = {};
        sObj.sobjectType = component.get('v.ObjectNameForApp');
        component.set('v.sObjectInfo', sObj);

        //call removeSelectedData methods on custom components
        component.get('v.theForm').forEach(function(key){
            if(!key.toString().includes('SecureComponentRef')){
                key.removeSelectedData();
            }
        });
    }

})