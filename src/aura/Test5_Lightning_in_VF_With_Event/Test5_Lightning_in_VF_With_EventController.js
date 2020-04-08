/**
 * Created by mryzhkouskaya on 16.11.2019.
 */
({
    fireComponentEvent : function(cmp, event) {

        // var cmpEvent = cmp.getEvent("cmpEvent");
        var cmpEvent = $A.get("e.c:Test5_Application_Event");
        cmpEvent.setParams({
            "message" : "A component event fired me. " +
                "It all happened so fast. Now, I'm here!" });
        cmpEvent.fire();
    }
})