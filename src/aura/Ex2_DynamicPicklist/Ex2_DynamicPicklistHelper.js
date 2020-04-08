/**
 * Created by mryzhkouskaya on 19.07.2019.
 */
({  configMap: {
        "picklist" : {
            componentDef: 'ui:inputSelect', attributes: {
                "class": "slds-select slds-select_container container",
            }
        },
    },


    init: function (component, event, helper) {

        let field = component.get('v.childAttrFieldValues');
        let numberOfPicklist = -1;

        let self = this;
        self.createComponents(component, event, helper, field, numberOfPicklist);
    },

    createComponents : function (component, event, helper, field, numberOfPicklist) {
        let configTemplate = this.configMap['picklist'];
        let config = JSON.parse(JSON.stringify(configTemplate));

        console.log('++create++ ');
        numberOfPicklist++;

        let options = [];
        options.push({
            value: null,
            label: 'Choose one...'
        });

        for (let k = 0; k < field.pickListValues.length; k++) {
            options.push({
                value: field.pickListValues[k].value,
                label: field.pickListValues[k].label
            });
        }
        config.attributes.options = options;
        config.attributes.label = field.fieldLabel;
        config.attributes['aura:id'] = numberOfPicklist;

        config.attributes.value = component.getReference("v.selectedValue");
        config.attributes.change = component.getReference("c.checkExistDependentPicklist");

        let inputDesc = component.get('v.inputDesc');
        inputDesc.push([
            config.componentDef,
            config.attributes
        ]);
        component.set('v.inputDesc', inputDesc);

        $A.createComponents( inputDesc, function(components) {
            component.set('v.theForm', components);
        });

        component.set('v.nameCurrentField', field.fieldAPIName);

    },


    checkExistDependentPicklist1: function(component, event, helper){
        console.log('in change');
        console.log('v.selectedValue1 ' + component.get('v.selectedValue'));

        var value = component.get("v.ui:inputSelect")[0].get("v.value");
        console.log('(((())))'+ value);

        let inputDesc = component.get('v.inputDesc');
        console.log('inputDesc.length '+ inputDesc.length);

        let fieldId = inputDesc[0][1]['aura:id'];
        console.log('fieldId'+ fieldId);

        let listFieldsWithDependency = component.get('v.childAttrListFieldsWithDependency');

        for (let i=0; i < listFieldsWithDependency.length; i++) {



            console.log('in for ' + i);

            let fieldWithDependency = listFieldsWithDependency[i];
            let controlField = JSON.parse(fieldWithDependency.hasControllerField);
            let nameCurrentField = component.get('v.nameCurrentField');

            if (nameCurrentField === controlField) {

                let action = component.get("c.getDependencyValues");
                action.setParams({
                    controllingField: controlField,
                    dependentField: fieldWithDependency.fieldAPIName
                });
                action.setCallback(this, function (response) {
                    let state = response.getState();
                    if (state === "SUCCESS") {

                        let mapWithDependentvalues = JSON.parse(response.getReturnValue());
                        let listValuesOfDependentPicklist = [];

                        Object.keys(mapWithDependentvalues).forEach(function (key) {
                            if (key === component.get('v.selectedValue')) {
                                listValuesOfDependentPicklist = mapWithDependentvalues[key];
                            }
                        });

                        let listOptionsOfDependentPicklist = [];
                        listValuesOfDependentPicklist.forEach(function (element) {
                            let optionValue = {
                                value: element,
                                label: element
                            };
                            listOptionsOfDependentPicklist.push(optionValue);
                        });

                        let field = {
                            fieldLabel: fieldWithDependency.fieldLabel,
                            pickListValues: listOptionsOfDependentPicklist,
                            fieldAPIName: fieldWithDependency.fieldAPIName
                        };

                        let self = this;
                        self.createComponents(component, event, helper, field);
                    }
                });
                $A.enqueueAction(action);
                break;
            }
        }


        // let inputDesc = component.get('v.inputDesc');
        inputDesc[0][1].value = component.get('v.selectedValue');
        component.set('v.inputDesc', inputDesc);
    },



    // fireEventToMainCmp: function(component, event, helper){
    //     console.log('fire event');
    //
    //
    //     var cmpEvent = component.getEvent("ex2toEx5Event");
    //     cmpEvent.setParams({
    //         "selectValue" : component.get('v.selectedValue'),
    //         'nameCurrentField' : component.get('v.nameCurrentField')});
    //     cmpEvent.fire();
    //
    // },
/////////////////////////////////////////////////////////////////////////////////////////////////

})