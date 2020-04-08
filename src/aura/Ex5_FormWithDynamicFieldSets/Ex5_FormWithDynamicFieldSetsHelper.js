/**
 * Created by mryzhkouskaya on 01.07.2019.
 */
({
    configMap: {
        "string": {
            // componentDef: "ui:inputText",
            componentDef: "lightning:input",
            attributes: {
                // "class": "slds-input container",
            }
        },
        "checkbox": {
            componentDef: "lightning:input",
            attributes: {
                "class": "slds-checkbox__label"
            }
        },
        "picklist": {
            componentDef: "ui:inputSelect",
            attributes: {
                "class": "slds-select slds-select_container container"
            }
        },
        "multipicklist": {
            componentDef: "lightning:dualListbox",
            attributes: {
                "sourceLabel": "Available Options",
                "selectedLabel": "Selected Options",
                "readOnly": false
            }
        },
        "textarea": {
            componentDef: "lightning:textarea",
            attributes: {
                // "class": "slds-input container",

            }
        },
        // "boolean": {componentDef: "markup://ui:inputCheckbox" },
        // "combobox": { componentDef: "lightning:input" },
        // "currency": { componentDef: "lightning:input" },
        // "datacategorygroupreference": { componentDef: "markup://ui:inputText" },
        // "date": { componentDef: "markup://ui:inputDate" },
        // "datetime": { componentDef: "markup://ui:inputDateTime" },
        // "double": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0.00"} } },
        // "email": { componentDef: "markup://ui:inputEmail" },
        // "encryptedstring": { componentDef: "markup://ui:inputText" },
        // "id": { componentDef: "lightning:input" },
        // "integer": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0"} } },
        // // "multipicklist": { componentDef: "markup://ui:inputText" },
        // "percent": { componentDef: "markup://ui:inputNumber", attributes: { values: { format: "0"} } },
        // // "picklist": { componentDef: "markup://ui:inputText" },
        // "reference": { componentDef: "lightning:input" },
        // "string": { componentDef: "lightning:input" , attributes: {  }},
        // // "textarea": { componentDef: "markup://ui:inputText" },
        // "time": { componentDef: "markup://ui:inputDateTime", attributes: { values: { format: "h:mm a"} } },
        // "url": { componentDef: "lightning:input" }

    },




    init: function (component, event, helper) {
        let self = this;

        let action = component.get("c.getFieldSetMember");
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let fieldSetMember = JSON.parse(response.getReturnValue());
                // console.log('fieldSetMember'+ fieldSetMember);
                self.createForm(component, event, helper, fieldSetMember);
            }
        });
        $A.enqueueAction(action);


    },

    createForm: function (component, event, helper, fieldSetMember) {

        let inputDesc = [];
        let config = null;
        let lightningInputMap = new Map();

        lightningInputMap.set('string', 'string');
        lightningInputMap.set('date', 'date');
        lightningInputMap.set('datetime', 'datetime');
        lightningInputMap.set('email', 'email');
        lightningInputMap.set('file', 'file');
        lightningInputMap.set('search', 'search');
        lightningInputMap.set('currency', 'currency');
        lightningInputMap.set('url', 'url');
        lightningInputMap.set('number', 'number');
        lightningInputMap.set('radio', 'radio');


        for (let i = 0; i < fieldSetMember.length; i++) {
            var objectName = component.getReference("v.sObjectInfo");

            let fieldSetType = fieldSetMember[i].fieldType.toLowerCase();
            if (lightningInputMap.has(fieldSetType)) {
                config = JSON.parse(
                    JSON.stringify(this.configMap['string'])
                );
                console.log('in string if ' + i);
                config.attributes.label = fieldSetMember[i].fieldLabel;
                // config.attributes.id = i;
                config.attributes.type = fieldSetMember[i].fieldType;
                config.attributes.required = fieldSetMember[i].isRequired;
                config.attributes.value = component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                inputDesc.push([
                    config.componentDef,
                    config.attributes
                ]);
            } else {
                if (fieldSetType === 'phone') {

                    config = JSON.parse(
                        JSON.stringify(this.configMap['string'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.type = 'tel';
                    config.attributes.required =
                        fieldSetMember[i].isRequired || fieldSetMember[i].isDBRequired;
                    config.attributes.pattern = "[0-9]{3}-[0-9]{2}-[0-9]{2}";
                    // config.attributes.value = '123-12-12';
                    config.attributes.value =
                        component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                } else if (fieldSetType === 'textarea') {

                    config = JSON.parse(
                        JSON.stringify(this.configMap['textarea'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.name = fieldSetMember[i].fieldLabel;
                    config.attributes.required = fieldSetMember[i].isRequired;
                    config.attributes.value =
                        component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                } else if (fieldSetType === 'picklist') {
                    config = JSON.parse(
                        JSON.stringify(this.configMap['picklist'])
                    );
                    if (fieldSetMember[i].fieldLabel === 'Street' ||
                        fieldSetMember[i].fieldLabel === 'Range of house numbers' ||
                        fieldSetMember[i].fieldLabel === 'Number of house') {
                        component.set("v.showDependentPicklist", true);
                    } else {
                        config.attributes.label = fieldSetMember[i].fieldLabel;
                        config.attributes.name = fieldSetMember[i].fieldLabel;
                        let pickList = fieldSetMember[i].pickListValues;
                        let options = [];
                        options.push({
                            value: null,
                            label: ' --- Select one --- '
                        });
                        for (let k = 0; k < pickList.length; k++) {
                            if (pickList[k].active) {
                                options.push({
                                    value: pickList[k].value,
                                    label: pickList[k].label
                                });
                            }
                        }
                        config.attributes.options = options;
                        config.attributes.required = fieldSetMember[i].isRequired;
                        config.attributes.value =
                            component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                        inputDesc.push([
                            config.componentDef,
                            config.attributes
                        ]);
                    }

                } else if (fieldSetType === 'multipicklist') {

                    config = JSON.parse(
                        JSON.stringify(this.configMap['multipicklist'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.name = fieldSetMember[i].fieldLabel;
                    let pickList = fieldSetMember[i].pickListValues;
                    let options = [];
                    for (let k = 0; k < pickList.length; k++) {
                        if (pickList[k].active) {
                            options.push({
                                value: pickList[k].value,
                                label: pickList[k].label
                            });
                        }
                    }
                    config.attributes.options = options;
                    config.attributes.required = [i].isRequired;
                    config.attributes.value =
                        component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                } else if (fieldSetType === 'boolean') {
                    config = JSON.parse(
                        JSON.stringify(this.configMap['string'])
                    );
                    config.attributes.label = fieldSetMember[i].fieldLabel;
                    config.attributes.type = 'checkbox';
                    config.attributes.required = fieldSetMember[i].isRequired;
                    config.attributes.value =
                        component.getReference('v.sObjectInfo.' + fieldSetMember[i].fieldAPIName);

                    inputDesc.push([
                        config.componentDef,
                        config.attributes
                    ]);
                }
            }
            component.set("v.listFieldSets", inputDesc);
        }


        $A.createComponents(inputDesc,
            function (components, status, errorMessage) {
                if (status === "SUCCESS") {
                    console.log('in create Comp');
                    let form = [];
                    for (let j = 0; j < components.length; j++) {
                        form.push(components[j]);
                    }
                    component.set("v.theForm", form);
                } else if (status === "INCOMPLETE") {
                    console.log("######No response from server or client is offline.");
                } else if (status === "ERROR") {
                    console.log("$$$$Error: " + errorMessage);
                    console.log(errorMessage);
                }
            }
        );

        $A.createComponent(
            "lightning:button",
            {
                "variant": "brand",
                "iconName": "utility:automate",
                "label": "Submit Form",
                "onclick": component.getReference("c.handlePress")
            },

            function(newButton, status, errorMessage){
                //Add the new button to the body array
                if (status === "SUCCESS") {
                    let button = component.get("v.subNutton");
                    button.push(newButton);
                    component.set("v.subNutton", button);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.");
                    // Show offline error
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                    // Show error message
                }
            }
        );
    },


    onUpsertObject : function(component, event, helper){
        let inputFieldArray = component.get('v.listFieldSets');

        console.log('INP '+inputFieldArray[0]);
        console.log('INP '+inputFieldArray[0].label);
        for (let i = 0; i < inputFieldArray.length; i++) {
            console.log('INP '+i);
        }

        let toastEvent = $A.get('e.force:showToast');

        let upsertObject = component.get('c.doUpsertObjects');
        upsertObject.setParams({
            "objectData" :  JSON.stringify(component.get('v.sObjectInfo'))
        });
        upsertObject.setCallback(this, function(response){
            let state = response.getState();
            if(component.isValid() && (state === 'SUCCESS' || state === 'DRAFT')){
                let upsertedRecord = JSON.parse(response.getReturnValue());
                if(toastEvent !== undefined){
                    toastEvent.setParams({
                        'title': 'Success!',
                        'type': 'success',
                        'mode': 'dismissable',
                        'message': 'Record was save success!'
                    });
                    toastEvent.fire();
                }else{
                    alert('Record was save success!');
                }
                document.location.reload(true);
            }else if(state==='INCOMPLETE'){
                console.log('User is Offline System does not support drafts '
                    + JSON.stringify(response.getError()));
            }else if(state ==='ERROR'){
                console.log(response.getError());
                if(toastEvent !== undefined){
                    toastEvent.setParams({
                        'title': 'Error!',
                        'type': 'error',
                        'mode': 'dismissable',
                        'message': 'Required fields are missing'
                    });
                    toastEvent.fire();
                }else{

                    alert('Required fields are missing');
                }
            }else{
                console.log('Unknown Error While making DML'
                    + JSON.stringify(response.getError()));
            }
        });
        $A.enqueueAction(upsertObject);
    },
});