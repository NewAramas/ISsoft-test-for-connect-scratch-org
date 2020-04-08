/**
 * Created by mryzhkouskaya on 08.07.2019.
 */
({
    init: function (component, helper) {

        let arrayFieldDependencies = component.get('v.childAttrArrayFieldDependencies');
        let arrayOfObjectFieldDependencies = [];
        console.log('%%% json' + arrayFieldDependencies);

        arrayFieldDependencies.forEach(function (element) {
            let fieldDependencies = JSON.parse(element);
            let controllField = JSON.parse(fieldDependencies[0]);
            var dependentObject = {
                controllingField: controllField,
                dependentField: fieldDependencies[1]
            };
            arrayOfObjectFieldDependencies.push(dependentObject);
        });
        console.log(' arrayOfObjectFieldDependencies[0] ',  arrayOfObjectFieldDependencies[0]);
        console.log(' arrayOfObjectFieldDependencies[0] '+  arrayOfObjectFieldDependencies[0].controllingField);
        console.log(' arrayOfObjectFieldDependencies[0] '+  arrayOfObjectFieldDependencies[0].dependentField);

        component.set('v.arrayFieldDependencies', arrayOfObjectFieldDependencies);
        let field1 = arrayOfObjectFieldDependencies[0].controllingField;
        let field2 = arrayOfObjectFieldDependencies[0].dependentField;
        let field3 = arrayOfObjectFieldDependencies[1].dependentField;


        let action = component.get("c.getAllStreetsOfContact");
        action.setParams({
            controllingField : arrayOfObjectFieldDependencies[0].controllingField,
            dependentField : arrayOfObjectFieldDependencies[0].dependentField
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let mapWithDependentvalues = JSON.parse(response.getReturnValue());
                console.log('MAP REturn' + mapWithDependentvalues);
                let listValuesAsNames = [];
                component.set("v.objectNamesToRangeOfHouseNumbers",mapWithDependentvalues);
                Object.keys(mapWithDependentvalues).map(function(key) {
                    listValuesAsNames.push(key);
                });
                component.set("v.picklistValuesOfStreetNames",listValuesAsNames );
            }
        });
        $A.enqueueAction(action);

        let ex2SelectedFields ={
        };
        component.set('v.objectSelectedValues', ex2SelectedFields);
    },

    fireSecondPickList: function (component, event, helper) {

        component.set("v.selectedRangeOfHouseNumbers",'-None-' );
        component.set("v.selectedHouseNumbers",'-None-' );
        component.set("v.showThirdPicklist",false);
        component.set("v.showSecondPicklist",true);

        let listRangesOfHouseNumbers = [];
        let mapWithDependentvalues = component.get("v.objectNamesToRangeOfHouseNumbers");

        let selectedFirstPicklistValue = component.get("v.selectedStreetName");
        console.log('STREET '+ selectedFirstPicklistValue);

        let arrayOfObjectFieldDependencies = component.get('v.arrayFieldDependencies');
        let field1 = arrayOfObjectFieldDependencies[0].controllingField;
        console.log('field1'+ field1);

        let ex2SelectedFields = component.get('v.objectSelectedValues');
        console.log('ex2SelectedFields'+ ex2SelectedFields);
        ex2SelectedFields[field1] = selectedFirstPicklistValue;
        ////////////////

        // let contactObj = component.get('v.childAttribute');
        // contactObj.Street__c = selectedStreetName;
        // component.set('v.childAttribute', contactObj);

        Object.keys(mapWithDependentvalues).forEach(function (key) {
            if(key === selectedFirstPicklistValue){
                listRangesOfHouseNumbers = mapWithDependentvalues[key];
            }
        });
        component.set("v.picklistValuesOfRange",listRangesOfHouseNumbers );
    },

    getSecondDependentOfPicklist: function (component, event) {

        let arrayOfObjectFieldDependencies = component.get('v.arrayFieldDependencies');
        console.log(' arrayOfObjectFieldDependencies[1] ',  arrayOfObjectFieldDependencies[1]);
        console.log(' arrayOfObjectFieldDependencies[1] '+  arrayOfObjectFieldDependencies[1].controllingField);
        console.log(' arrayOfObjectFieldDependencies[1] '+  arrayOfObjectFieldDependencies[1].dependentField);

        let action = component.get("c.getAllStreetsOfContact");
        action.setParams({
            controllingField : arrayOfObjectFieldDependencies[1].controllingField,
            dependentField : arrayOfObjectFieldDependencies[1].dependentField
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let mapWithDependentValues = JSON.parse(response.getReturnValue());
                let listValuesAsNames = [];
                component.set("v.objectRangeOfHouseNumbersToNumbers",mapWithDependentValues);
            }
        });
        $A.enqueueAction(action);
    },


    fireThirdPickList: function (component, event) {

        component.set("v.selectedHouseNumbers",'-None-' );
        component.set("v.showThirdPicklist",true);

        let listOfHouseNumbers = [];
        let mapWithDependentvalues = component.get("v.objectRangeOfHouseNumbersToNumbers");

        let selectedSecondPicklistValue = component.get("v.selectedRangeOfHouseNumbers");

        // let contactObj = component.get('v.childAttribute');
        // contactObj.Range_of_house_numbers__c = selectedRange;
        // component.set('v.childAttribute', contactObj);

        let arrayOfObjectFieldDependencies = component.get('v.arrayFieldDependencies');
        let field2 = arrayOfObjectFieldDependencies[0].dependentField;

        let ex2SelectedFields = component.get('v.objectSelectedValues');
        ex2SelectedFields[field2] = selectedSecondPicklistValue;

        Object.keys(mapWithDependentvalues).forEach(function (key) {
            if(key === selectedSecondPicklistValue){
                listOfHouseNumbers = mapWithDependentvalues[key];
            }
        });
        component.set("v.picklistValuesOfNumbers",listOfHouseNumbers );
    },

    fireEventToMainCmp: function (component, event) {

        let ex2SelectedFields = component.get('v.objectSelectedValues');
        console.log("ex2selected ", ex2SelectedFields.Street__c);

    },
})