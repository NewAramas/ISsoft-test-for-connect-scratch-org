/**
 * Created by mryzhkouskaya on 10.06.2019.
 */

({
    setRecordsAndFieldsIntoTable : function(component, event, helper) {
        helper.setRecordsAndFieldsIntoTable(component, event, helper);
    },

    deleteRecordById : function(component, event, helper) {
        if(confirm('Are you sure?'))
            helper.deleteRecordById(component, event);
    },


    createNewRecord : function(component, event, helper) {

        helper.createNewRecord(component, event);
    },

    editRecord: function (component, event, helper) {

        helper.editRecordById(component, event);
    },

    updateEditRecords: function(component, event, helper){

        helper.updateEditRecords(component, event);
    },

    navigateToObject: function(component, event, helper){

        helper.navigateToObject(component, event);
    },

    view : function(component, event, helper) {

        helper.viewRecordById(component, event);

    },
    closeModel: function(component, event, helper) {

        helper.closeModel(component, event);
    },

});