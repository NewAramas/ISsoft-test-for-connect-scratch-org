/**
 * Created by mryzhkouskaya on 04.06.2019.
 */

({
    init: function (component, helper) {

        let action = component.get("c.getAllObjectNamesIntoPicklist");

        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.picklistValuesOfObjectNames", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },

    fireComponentEvent: function (component, event) {

        let cmpEvent = component.getEvent("cmpEvent");
        cmpEvent.setParams({
            "objectName": event.getParam('value')
        });
        cmpEvent.fire();
    }
});