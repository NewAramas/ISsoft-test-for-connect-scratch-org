/**
 * Created by mryzhkouskaya on 17.07.2019.
 */
({
    configMap: {
        "picklist" : {
            componentDef: 'ui:inputSelect', attributes: {
                "class": "slds-select slds-select_container container",
            }
        },

    },

    init: function (component, event, helper) {
        let arrayFieldDependencies = component.get('v.childAttrListControllerToDependentField');
        console.log('((( '+ arrayFieldDependencies);


        let arrayOfObjectFieldDependencies = [];
      //  console.log('%%% json' + arrayFieldDependencies);

        arrayFieldDependencies.forEach(function (element) {
            let fieldDependencies = JSON.parse(element);
            let controllField = JSON.parse(fieldDependencies[0]);
            let dependentObject = {
                controllingField: controllField,
                dependentField: fieldDependencies[1]
            };
            arrayOfObjectFieldDependencies.push(dependentObject);
            component.set('v.arrayOfObjectFieldDependencies', arrayOfObjectFieldDependencies);
        });

        let self = this;
        self.getDependencyValues(component, event, helper);

    },

    getDependencyValues: function(component, event, helper){

        let currentDependencies = component.get('v.currentDependencies');
        currentDependencies = currentDependencies + 1;
        component.set('v.currentDependencies', currentDependencies);

      //  console.log('v.currentDependencies'+ currentDependencies);
        let arrayOfObjectFieldDependencies = component.get('v.arrayOfObjectFieldDependencies');

        let action = component.get("c.getAllStreetsOfContact");
        action.setParams({
            controllingField : arrayOfObjectFieldDependencies[currentDependencies].controllingField,
            dependentField : arrayOfObjectFieldDependencies[currentDependencies].dependentField
        });
        action.setCallback(this, function (response) {
            let state = response.getState();
          //  console.log('status?????'+ state);
            if (state === "SUCCESS") {

                let mapWithDependentvalues = JSON.parse(response.getReturnValue());
                component.set("v.objectNamesToRangeOfHouseNumbers",mapWithDependentvalues);

                let inputDesc = [];
                component.set('v.inputDesc', inputDesc);
                let self = this;
                self.createPicklists(component, event, helper);
            }
        });
        $A.enqueueAction(action);
    },
    createPicklists: function(component, event, helper) {

        let self = this;

        let selectedValue = component.get('v.selectedValue');
        let mapWithDependentvalues = component.get('v.objectNamesToRangeOfHouseNumbers');

        let configTemplate = this.configMap['picklist'];
        let config = JSON.parse(JSON.stringify(configTemplate));

        if(selectedValue === ''){

            let inputDesc = component.get('v.inputDesc');
            let listValuesOfFirsPicklist = [];

            Object.keys(mapWithDependentvalues).map(function(key) {
                listValuesOfFirsPicklist.push(key);
            });
            component.set("v.picklistValues",listValuesOfFirsPicklist );

            config.attributes.change = component.getReference("c.reload");
            self.addOptions(component, event, helper);
////////////////////////////////////
            config.attributes.options = component.get('v.options');
            config.attributes.value = component.getReference("v.selectedValue");
            config.attributes.label = 'Depend';

            inputDesc.push([
                config.componentDef,
                config.attributes
            ]);

            $A.createComponents( inputDesc, function(components) {
                component.set('v.theForm', components);
            });
//////////////////////////////
        }else{
          //  console.log('*****9***');
            //console.log('***' + component.get('v.selectedValue'));

            let inputDesc = component.get('v.inputDesc');
            let listValuesOfSecondPicklist = [];

            Object.keys(mapWithDependentvalues).forEach(function (key) {
                if(key === selectedValue){
                    listValuesOfSecondPicklist = mapWithDependentvalues[key];
                }
            });
            component.set("v.picklistValues",listValuesOfSecondPicklist);

            self.addOptions(component, event, helper);
//////////////////////////
            config.attributes.options = component.get('v.options');
            config.attributes.value = component.getReference("v.selectedValue");
            config.attributes.change = component.getReference("c.loadNextDependency");

            inputDesc.push([
                config.componentDef,
                config.attributes
            ]);

            $A.createComponents( inputDesc, function(components) {
                component.set('v.theForm', components);
            });
  ////////////////////
        }
    },

    addOptions: function(component, event, helper) {
        //console.log('*****11***');

        let pickList = component.get('v.picklistValues');

        let options = [];
        options.push({
            value: null,
            label: 'Choose one22...'
        });
        for (let k = 0; k < pickList.length; k++) {
            options.push({
                value: pickList[k],
                label: pickList[k]
            });
        }
        component.set('v.options', options);
       // console.log('options Depend picklists ', options);
    }


})