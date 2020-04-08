/**
 * Created by mryzhkouskaya on 30.07.2019.
 */
({
    init: function(component, event, helper) {
        console.log('in init ex2');
        helper.init(component, event);
    },

    setOptionsOnNextPicklist: function (component, event, helper) {

        component.set("v.showSpinner", true);

        let choice = event.getSource().get("v.value");
        let type = event.getSource().get("v.name");

        let indexOfComboboxInInputDesc = parseInt(type, 10);

        let currentFieldAPIName;
        if (indexOfComboboxInInputDesc < 10) {
            currentFieldAPIName = type.slice(1);
        } else {
            currentFieldAPIName = type.slice(2);
        }

        helper.setOptionsOnNextPicklist(component, event, helper, indexOfComboboxInInputDesc, currentFieldAPIName, choice);
    },

     checkValidDepPicklists : function(component, event, helper) {
         console.log("check validation on ex2 cmp");
         return helper.checkValidDepPicklists(component, event, helper);

    },
    removeSelectedData : function(component, event, helper) {
        console.log("remove data on ex2 cmp");
        helper.init(component, event, helper);

    },
})