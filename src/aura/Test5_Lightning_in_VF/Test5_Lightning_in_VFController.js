/**
 * Created by mryzhkouskaya on 16.11.2019.
 */
({
    handleComponentEvent : function(cmp, event) {
        var message = event.getParam("message");

        // set the handler attributes based on event data
        cmp.set("v.messageFromEvent", message);
        var numEventsHandled = parseInt(cmp.get("v.numEvents")) + 1;
        cmp.set("v.numEvents", numEventsHandled);
    },

    onCallChildMethod : function(component, event, helper) {
        var attribute1 = component.get('v.parentAttribute1');
        var attribute2 = component.get('v.parentAttribute2');
        var childComponent = component.find('child');
        childComponent.myMethod(attribute1, attribute2);
    }
})