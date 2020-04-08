/**
 * Created by mryzhkouskaya on 14.06.2019.
 */

({
    init: function (component, event, helper) {

        helper.init(component, event);
    },

    fireSecondPickList: function (component, event, helper) {

        helper.fireSecondPickList(component, event);
    },

    getSecondDependentOfPicklist: function (component, event, helper) {

        helper.getSecondDependentOfPicklist(component, event);
    },

    fireThirdPickList: function (component, event, helper) {

        helper.fireThirdPickList(component, event);
    },

    fireEventToMainCmp: function (component, event, helper) {

        let selectedThirdPicklistValue = component.get("v.selectedHouseNumbers");

        // let contactObj = component.get('v.childAttribute');
        // contactObj.Number_of_house__c = selectedNumberHouse;
        // component.set('v.childAttribute', contactObj);

        let arrayOfObjectFieldDependencies = component.get('v.arrayFieldDependencies');
        let field3 = arrayOfObjectFieldDependencies[1].dependentField;

        let ex2SelectedFields = component.get('v.objectSelectedValues');
        ex2SelectedFields[field3] = selectedThirdPicklistValue;
        helper.fireEventToMainCmp(component, event);
    }
});