/**
 * Created by mryzhkouskaya on 17.07.2019.
 */
({
    init: function(component, event, helper) {

        helper.init(component, event);
    },
    reload: function(component, event, helper){
        helper.createPicklists(component, event);
    },
    loadNextDependency: function(component, event, helper){
        helper.getDependencyValues(component, event);
    }
})