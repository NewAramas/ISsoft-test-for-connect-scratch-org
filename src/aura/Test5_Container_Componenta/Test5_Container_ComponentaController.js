/**
 * Created by mryzhkouskaya on 18.11.2019.
 */
({
    doRefreshView : function(component, event) {

        $A.get('e.force:refreshView').fire();
    }
})