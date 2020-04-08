/**
 * Created by mryzhkouskaya on 17.10.2019.
 */
({

    handleSelectObject: function (component, event, helper) {

        helper.handleSelectObject(component, event);
    },

    handleSelectTypeCreationRecord: function (component, event, helper) {

        helper.handleSelectTypeCreationRecord(component, event);
    },

    goToCreationTab: function (component, event, helper) {

        helper.goToCreationTab(component, event);
    },

    //for pop up

    goToCreationRecordPopUp: function (component, event, helper) {
        let response = helper.checkValidEmail(component, event);
        let validityEmail = component.get('v.validEmail');
        if (!validityEmail) {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "Invalid email.",
                "type": "error"
            });
            toastEvent.fire();
        } else if ((component.get('v.flagShowComboboxWithFieldsSets') === true && component.get('v.selectedFieldSet') !== '') ||
            (component.get('v.flagShowInputFields') === true && component.get('v.listFields') !== '')) {
            component.set("v.isOpen", true);
            console.log('In if FieldsSets == true');
        } else {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error",
                "message": "You didn't select fieldSet or enter field names.",
                "type": "error"
            });
            toastEvent.fire();
        }
    },

    openModel: function(component, event, helper) {
        component.set("v.isOpen", true);
    },

    closeModel: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    thanksEnClose: function(component, event, helper) {
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    },

    getValidityEmail : function(component, event, helper) {
        let validity = event.getSource().get("v.validity");
        component.set('v.validEmail', validity.valid);
    }
})