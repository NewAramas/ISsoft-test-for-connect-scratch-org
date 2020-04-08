/**
 * Created by mryzhkouskaya on 04.06.2019.
 */

({
    setFieldsIntoListBox : function(component, event) {
        let fieldNames = event.getParam('arguments').attrSelectedFields;

        let list = JSON.parse(fieldNames);
        let selectedFields = [];

        if (list) {
            let mapFieldAPINameToLabel = new Map();
            list.forEach(function(item){
                mapFieldAPINameToLabel.set(item.APIName, item);
            });
            
            let fields11WithLabelAndValue = [];

            mapFieldAPINameToLabel.forEach(function (item, APIName) {
                fields11WithLabelAndValue.push({
                    label: item.APILabel,
                    value: APIName,
                    field: item
                });
            });
            component.set("v.availableFieldNames",fields11WithLabelAndValue);
            component.set("v.selectedFieldNames", selectedFields);
        }
    },

    fireCmpChoiceFieldEvent: function (component, event) {

        let selectedFields = component.get("v.selectedFieldNames");

        if(selectedFields[0] !== undefined){
            let cmpChoiceFieldEvent = component.getEvent("cmpChoiceFieldEvent");
            cmpChoiceFieldEvent.setParams({
                "attributeSelectedFields": selectedFields
            });
            cmpChoiceFieldEvent.fire();
        }else{
            alert('You should select any field');
        }
    }
});