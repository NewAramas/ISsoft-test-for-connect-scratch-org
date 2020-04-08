/**
 * Created by mryzhkouskaya on 21.06.2019.
 */
({
    onblur : function(component,event,helper){

        component.set("v.listOfSearchRecords", null );
        component.set("v.SearchKeyWord", '');
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');

    },
    onfocus : function(component,event,helper){

        $A.util.addClass(component.find("mySpinner"), "slds-show");
        component.set("v.listOfSearchRecords", null );
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');

        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
    },

    keyPressController : function(component, event, helper) {

        $A.util.addClass(component.find("mySpinner"), "slds-show");
        var getInputkeyWord = component.get("v.SearchKeyWord");

        if(getInputkeyWord.length > 0){
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(component,event,getInputkeyWord);
        }
        else{
            component.set("v.listOfSearchRecords", null );
            var forClose = component.find("searchRes");
            $A.util.addClass(forClose, 'slds-is-close');
            $A.util.removeClass(forClose, 'slds-is-open');
        }

    },

    //// function for delete in selected place
    clear :function(component,event,helper){
        var selectedPillId = event.getSource().get("v.name");
        var AllPillsList = component.get("v.lstSelectedRecords");

        for(var i = 0; i < AllPillsList.length; i++){
            if(AllPillsList[i].Id === selectedPillId){
                AllPillsList.splice(i, 1);
                component.set("v.lstSelectedRecords", AllPillsList);
            }
        }
        component.set("v.SearchKeyWord",null);
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);
        // component.set("v.listOfSearchRecords", null );
    },


    handleComponentEvent : function(component, event, helper) {
        component.set("v.SearchKeyWord",null);
        var listSelectedItems =  component.get("v.lstSelectedRecords");

        var selectedAccountGetFromEvent = event.getParam("recordByEvent");
        listSelectedItems.push(selectedAccountGetFromEvent);
        component.set("v.lstSelectedRecords" , listSelectedItems);

        var forClose = component.find("lookup-pill");
        $A.util.addClass(forClose, 'slds-show');
        $A.util.removeClass(forClose, 'slds-hide');
        var getInputkeyWord = '';
        helper.searchHelper(component,event,getInputkeyWord);

        // var forclose = component.find("searchRes");
        // $A.util.addClass(forclose, 'slds-is-close');
        // $A.util.removeClass(forclose, 'slds-is-open');
    },

    createNewRecord : function(component, event, helper) {
        component.set("v.showCreateWindow", true);
    },
    closeModel: function(component, event, helper) {
        component.set("v.showCreateWindow",false);
    }
})