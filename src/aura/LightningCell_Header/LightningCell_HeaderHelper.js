/**
 * Created by mryzhkouskaya on 04.06.2019.
 */

({
    sortByAbex: function(component, event, helper) {

        let listRecords = component.get('v.rowData');
        let fieldApiName =  component.get('v.colName');
        let sortAsc =  component.get('v.sortAsc');

        let mapFieldValueById = new Map();
        listRecords.forEach(function(element) {
            mapFieldValueById[element.Id] = element[fieldApiName];
        });

        let action = component.get("c.sortRecordsByFieldName");
        action.setParams({
            mapIdToFieldvalue: mapFieldValueById
        });

        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let listSortObjects = [];
                let listSortWrapper = response.getReturnValue();
                listSortWrapper.forEach(function(elementWrapper) {
                    listRecords.forEach(function(record) {
                        if(elementWrapper.id === record.Id){
                            listSortObjects.push(record);
                        }
                    });
                });
                if(sortAsc===true){
                    sortAsc = false;
                    component.set("v.rowData",listSortObjects);
                }else{
                    var listSortObjectsDESC = [];
                    sortAsc = true;
                    for(let i=listSortObjects.length-1; i>=0; i--) {
                        listSortObjectsDESC.push( listSortObjects[i]);
                    }
                    component.set("v.rowData",listSortObjectsDESC);
                }
                component.set("v.sortAsc",sortAsc);

            } else {
                let errors = response.getError()[0].message;
                console.log(errors);
            }
        });
        $A.enqueueAction(action);
    }
});