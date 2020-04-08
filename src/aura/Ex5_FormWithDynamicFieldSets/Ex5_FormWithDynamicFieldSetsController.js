/**
 * Created by mryzhkouskaya on 24.06.2019.
 */
({
    init: function (component, event, helper) {
        helper.init(component, event);
    },
    handlePress : function(component, event, helper) {
        helper.onUpsertObject(component, event, helper);
    },
    ////////
    handleError : function (cmp, evt, helper){
        alert("An error was found in your input.");
    },
    handleValidate : function (component, evt, helper){

        var field1 = component.find("expenseform1");
        if(field1.get("v.validity").valid) {
            // continue processing
        } else {
            field1.showHelpMessageIfInvalid();
        }

        var num = component.find("number");
        var val = num.get("v.value");
        if (val<10) {
            num.set("v.errors", [{message:"Enter a number more than 10"}]);
        } else {
            num.set("v.errors", null);
        }
    },
})