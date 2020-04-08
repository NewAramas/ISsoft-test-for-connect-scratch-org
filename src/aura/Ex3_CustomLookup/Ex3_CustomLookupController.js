/**
 * Created by mryzhkouskaya on 19.06.2019.
 */
({
    // To prepopulate the seleted value pill if value attribute is filled
    doInit : function( component, event, helper ) {
        console.log('in init ex3');


        // if(component.get('v.selectedRecord').value === undefined ){
        //     component.set('v.flagShowRequireAttribute', 'true');
        // }else{
        //     component.set('v.flagShowRequireAttribute', 'false');
        // }


        // ||component.get('v.selectedRecord').value === undefined ||
        // component.get('v.selectedRecord').value === ''

        //console.log('in init ex3'+ component.get('v.selectedRecord').value);

        $A.util.toggleClass(component.find('resultsDiv'),'slds-is-open');
        if (!$A.util.isEmpty(component.get('v.value'))) {

            helper.searchRecordsHelper( component, event, helper, component.get('v.value') );
        }
    },

    // When a keyword is entered in search box
    searchRecords : function( component, event, helper ) {
        if (!$A.util.isEmpty(component.get('v.searchString'))) {
            helper.searchRecordsHelper( component, event, helper, '' );

        } else {
            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
        }
    },

    // When an item is selected
    selectItem : function( component, event, helper ) {
        if (!$A.util.isEmpty(event.currentTarget.id)) {
            let recordsList = component.get('v.recordsList');
            let index = recordsList.findIndex(x => x.value === event.currentTarget.id);
            let selectedRecord;
            if (index !== -1) {
                selectedRecord = recordsList[index];
            }
            component.set('v.selectedRecord',selectedRecord);
            component.set('v.value',selectedRecord.value);

            if (component.get('v.required')) {
                $A.util.removeClass(component.find("requiredID"), "slds-hidden");
            }

            let fieldNameToSet = component.get('v.fieldNameOfToSetObject');

            let ex3ToEx5cmpEvent = component.getEvent("ex3ToEx5SelectedLookupValuesEvent");
            ex3ToEx5cmpEvent.setParams({
                "selectID" : selectedRecord.value,
                "fieldNameOfToSetObject" : fieldNameToSet });
            ex3ToEx5cmpEvent.fire();

            $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
        }
    },



    // To close the dropdown if clicked outside the dropdown.
    blurEvent : function( component, event, helper ){
        $A.util.removeClass(component.find('resultsDiv'),'slds-is-open');
    },

    checkValidationOnRequired : function (component, event, helper) {
        console.log("check validation on ex3 cmp");

        let selectedRecord = component.get('v.selectedRecord');
        if (selectedRecord.value == null && component.get('v.required')){
            let requiredField = component.find('inputLookup');
            //throw exception if required field is empty
            requiredField.showHelpMessageIfInvalid();
            return false;
        } else {
            return true;
        }
    },

    removeSelectedData : function(component, event, helper) {
        console.log("remove data on ex3 cmp");
        helper.removeItem(component, event, helper);
    }
})