/**
 * Created by mryzhkouskaya on 16.11.2019.
 */
({
    executeMyMethod : function (component, event, helper) {
        var params = event.getParam('arguments');
        console.log('Param 1: '+ params.param1);
        component.set("v.param3", params.param1);
    },
    doRefreshView : function(component, event) {

        // $A.get('e.force:refreshView').fire();
        window.location.reload();
    },
    doShowToast : function(component, event) {


        try {
            // for classic version
            // I use visualforce page showToast
            sforce.one.showToast({
                    "title": "Success!",
                    "message": "Welcome to salesforce code crack.",
                    "type": "success"
                });

        } catch (e) {
            //for lightning version
            // component.set("v.isOpen", true);
            setTimeout(function(){
                component.set("v.isOpen", true);
            }, 5000);

        } finally {
            // Something executed whether there was an error or not
        }




        // toastEvent.setParams({
        //     "title": "Success!",
        //     "message": "The record has been upserted successfully.",
        //     "type": "success"
        // });
        // toastEvent.fire();
    },
    // openModelWithShowToast: function(component, event, helper) {
    //     component.set("v.isOpen", true);
    // },

    closeModelWithShowToast: function(component, event, helper) {
        component.set("v.isOpen", false);
    },

    createAuraComponent : function(cmp, event, helper){
        $A.createComponent(
            "lightning:button",
            {
                "aura:id": "findableAuraId",
                "label": "Press Me"
            },
            function(newButton, status, errorMessage){
                console.log('In creation component');
                if (status === "SUCCESS") {
                    var body = cmp.get("v.body");
                    body.push(newButton);
                    cmp.set("v.body", body);
                }
                else if (status === "INCOMPLETE") {
                    console.log("No response from server or client is offline.")
                }
                else if (status === "ERROR") {
                    console.log("Error: " + errorMessage);
                }
            });


    },






})