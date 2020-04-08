/**
 * Created by mryzhkouskaya on 30.07.2019.
 */
({

    init: function (component, event, helper) {
        console.log('in ex2 helper');
        let inputDesc = [];
        let listFieldsWithDependency = component.get('v.fieldsdWithDependency');
        let arrayOfOrderOfDependentPicklists = component.get('v.arrayOfOrderOfDependentPicklists');

        let arr = [];
        arr[0] = 'str';

        // set the first picklist to inputDesc
        let numberOfComboboxInOrder;
        let currentFieldName = '';

        for (let i = 0; i < listFieldsWithDependency.length; i++) {
            let field = listFieldsWithDependency[i];
            if (field.nameControllerField === null) {

                arrayOfOrderOfDependentPicklists[0] = field.fieldAPIName;

                let options = [];
                options.push({
                    value: null,
                    label: '--None--'
                });
                for (let k = 0; k < field.pickListValues.length; k++) {
                    options.push({
                        value: field.pickListValues[k].value,
                        label: field.pickListValues[k].label
                    });
                }
                numberOfComboboxInOrder = 0;
                inputDesc.push(["lightning:combobox", {"label": field.fieldLabel,
                                                        "name" : numberOfComboboxInOrder + field.fieldAPIName,
                                                        "options": options,
                                                        'required': field.isRequired,
                                                        "onchange":component.getReference("c.setOptionsOnNextPicklist"),
                                                        'aura:id': 1}
                                                        ]);
                currentFieldName = field.fieldAPIName;
            }
        }

        // set others dependent picklist in necessary order
        let options = [];
        let i = 0;
        let k = 0;
        while (i < listFieldsWithDependency.length) {

            let field = listFieldsWithDependency[i];
            if (field.nameControllerField === currentFieldName) {

                arrayOfOrderOfDependentPicklists[k+1] = field.fieldAPIName;
                k++;

                numberOfComboboxInOrder ++;
                inputDesc.push( ["lightning:combobox", { "label": field.fieldLabel,
                                                         "name": numberOfComboboxInOrder + field.fieldAPIName,
                                                         "options" : options,
                                                         "disabled": true,
                                                         'required': field.isRequired,
                                                         "onchange": component.getReference("c.setOptionsOnNextPicklist"),
                                                         'aura:id': i+2
                                                        }]);
                currentFieldName = field.fieldAPIName;
                i = 0;
            } else {
                i++;
            }
        }
        component.set('v.arrayOfOrderOfDependentPicklists', arrayOfOrderOfDependentPicklists);
        component.set('v.inputDesc_Ex2', inputDesc);

        // create picklists
        $A.createComponents( inputDesc, function(components) {
            component.set('v.theForm', components);
        });
    },

    setOptionsOnNextPicklist: function (component, event, helper, indexOfComboboxInInputDesc, currentFieldAPIName, selectedValue) {
        let inputDesc = component.get('v.inputDesc_Ex2');

        //update data of selected values in arraySelectedValue
        let arraySelectedValue = component.get('v.arraySelectedValue');
        arraySelectedValue[indexOfComboboxInInputDesc] = selectedValue;
        component.set('v.arraySelectedValue', arraySelectedValue);

        inputDesc[indexOfComboboxInInputDesc][1].value = arraySelectedValue[indexOfComboboxInInputDesc];

        //disabled unnecessary dependent picklists
        for(let i = indexOfComboboxInInputDesc; i + 2 < inputDesc.length; i++) {

            inputDesc[i + 1][1].value = undefined;
            inputDesc[i + 2][1].options = [];
            inputDesc[i + 2][1].disabled = true;
        }
        inputDesc[inputDesc.length -1][1].value = undefined;

        // define what current field
        let currentField;
        let listFieldsWithDependency = component.get('v.fieldsdWithDependency');
        for (let i = 0; i < listFieldsWithDependency.length; i++) {
            let field = listFieldsWithDependency[i];
            if (field.fieldAPIName === currentFieldAPIName) {
                currentField = field;
            }
        }

        //get options of dependent picklist
        let action = component.get("c.getDependencyValues");
        action.setParams({
            controllingField: currentField.fieldAPIName,
            dependentField: currentField.nameNextPicklist
        });
        action.setCallback(this, function (response) {

            component.set("v.showSpinner", false);

            let state = response.getState();
            if (state === "SUCCESS") {

                let mapWithDependentvalues = JSON.parse(response.getReturnValue());
                let listValuesOfDependentPicklist = [];

                Object.keys(mapWithDependentvalues).forEach(function (key) {
                    if (key === selectedValue) {
                        listValuesOfDependentPicklist = mapWithDependentvalues[key];
                    }
                });

                //set options on dependent picklist
                let listOptionsOfDependentPicklist = [];
                listOptionsOfDependentPicklist.push({
                    value: null,
                    label: '--None--'
                });
                listValuesOfDependentPicklist.forEach(function (element) {
                    let optionValue = {
                        value: element,
                        label: element
                    };
                    listOptionsOfDependentPicklist.push(optionValue);
                });

                inputDesc[indexOfComboboxInInputDesc + 1][1].options = listOptionsOfDependentPicklist;

                if(inputDesc[indexOfComboboxInInputDesc][1].value === null &&
                    indexOfComboboxInInputDesc +2 !== inputDesc.length){
                    inputDesc[indexOfComboboxInInputDesc + 1][1].disabled = true;
                }else{
                    inputDesc[indexOfComboboxInInputDesc + 1][1].disabled = false;
                }

                // recreate all dependent picklists
                $A.createComponents( inputDesc, function(components) {
                    component.set('v.theForm', components);
                });
            }
        });
        $A.enqueueAction(action);

        component.set('v.inputDesc_Ex2',inputDesc);
    },

    checkValidDepPicklists: function(component, event, helper){

        console.log("check validation on ex2 helper cmp");
        // check on filling required fields
        let inputDesc = component.get('v.inputDesc_Ex2');

        let amountValidInputs = 0;
        let amountRequiredInputs = 0;
        if (inputDesc.length !== 0) {

            for (let i = 0; i < inputDesc.length; i++) {

                if (inputDesc[i][1].required === true) {
                    amountRequiredInputs++;
                    let fieldId = inputDesc[i][1]['aura:id'];
                    let requiredField = component.find(fieldId);

                    let lastModifiedOfField;
                    if(requiredField.length === undefined){
                        lastModifiedOfField = requiredField;
                    }else {
                        lastModifiedOfField = requiredField[requiredField.length - 1];
                    }

                    if (lastModifiedOfField.get("v.validity").valid) {
                        amountValidInputs++;
                    } else {
                        //throw exception if required field is empty
                        lastModifiedOfField.showHelpMessageIfInvalid();
                        return false;
                    }
                }
            }
        } else {
            return true;
        }


        // if all dependent picklists fields are valid - call fire event  method to main cmp
        if(amountRequiredInputs === amountValidInputs){

            let self = this;
            self.fireEventToMainCmp(component, event, helper);
            return true;
        }
    },

    fireEventToMainCmp: function(component, event, helper){

        //sent selected values to main values

        let arraySelectedValue = component.get('v.arraySelectedValue');
        let arrayOfOrderOfDependentPicklists = component.get('v.arrayOfOrderOfDependentPicklists');

        let objWithSelectedValues = {};
        let fieldName;

        for(let i = 0; i < arraySelectedValue.length; i++){
            fieldName = arrayOfOrderOfDependentPicklists[i];
            objWithSelectedValues[fieldName] = arraySelectedValue[i];
        }

        let ex2ToEx5SelectedValuesEvent = component.getEvent("ex2ToEx5SelectedValuesEvent");
        ex2ToEx5SelectedValuesEvent.setParams({
            "objWithSelectedValues" : objWithSelectedValues });
        ex2ToEx5SelectedValuesEvent.fire();
    }

})