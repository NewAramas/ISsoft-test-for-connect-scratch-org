/**
 * Created by mryzhkouskaya on 19.06.2019.
 */
({
    searchRecordsHelper : function(component, event, helper, value) {
        console.log('in helper in lookup');
        // $A.util.removeClass(component.find("Spinner"), "slds-hide");
        component.set('v.message','');
        component.set('v.recordsList',null);
        // Calling Apex Method
        let action = component.get('c.fetchRecords');
        action.setStorable();
        action.setParams({
            'objectName' : component.get('v.objectName'),
            'filterField' : 'Name',
            'searchString' : component.get('v.searchString')
        });
        action.setCallback(this,function(response){
            let result = response.getReturnValue();
            if (response.getState() === 'SUCCESS') {
                // To check if any records are found for searched keyword
                if (result.length > 0) {
                    // To check if value attribute is prepopulated or not
                    if ( $A.util.isEmpty(value) ) {
                        component.set('v.recordsList',result);
                    } else {
                        let index = result.findIndex(x => x.value === value);
                        if (index !== -1) {
                            let selectedRecord = result[index];
                        }
                        component.set('v.selectedRecord',selectedRecord);
                    }
                } else {
                    component.set('v.message','No Records Found');
                }
            } else if(response.getState() === 'INCOMPLETE') {
                component.set('v.message','No Server Response or client is offline');
            } else if(response.getState() === 'ERROR') {
                // If server throws any error
                let errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    component.set('v.message', errors[0].message);
                }
            }
            // To open the drop down list of records
            if( $A.util.isEmpty(value) )
                $A.util.addClass(component.find('resultsDiv'),'slds-is-open');
            $A.util.addClass(component.find('Spinner'), 'slds-hide');
            //setTimeout($A.getCallback(() => this.searchRecordsHelper(component)), 10000);
        });
        $A.enqueueAction(action);
    },
    // To remove the selected item.
    removeItem : function( component, event, helper ){
        component.set('v.selectedRecord','');
        component.set('v.value','');
        component.set('v.searchString','');
        setTimeout( function() {
            component.find( 'inputLookup' ).focus();
        }, 250);
    }
})