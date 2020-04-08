/**
 * Created by mryzhkouskaya on 17.06.2019.
 */

public with sharing class Ex2_DependentPickListValueController {

    public  Ex2_DependentPickListValueController(){}
    public  static Map<String,List<String>> getDependentOptions(
            String pObjName,
            String pControllingFieldName,
            String pDependentFieldName)
    {
        Map<String,List<String>> objResults = new Map<String,List<String>>();
        Map<String,Schema.SObjectType> objGlobalMap = Schema.getGlobalDescribe();
        Schema.SObjectType pType = objGlobalMap.get(pObjName);
        Map<String, Schema.SObjectField> objFieldMap = pType.getDescribe().fields.getMap();
        List<Schema.PicklistEntry> ctrl_ple = objFieldMap.get(pControllingFieldName).getDescribe().getPicklistValues();
        List<Schema.PicklistEntry> dep_ple = objFieldMap.get(pDependentFieldName).getDescribe().getPicklistValues();
        Ex2_PickListUtils.Bitset objBitSet = new Ex2_PickListUtils.Bitset();

        for(Integer pControllingIndex = 0; pControllingIndex < ctrl_ple.size(); pControllingIndex++){
            Schema.PicklistEntry ctrl_entry = ctrl_ple[pControllingIndex];
            String pControllingLabel = ctrl_entry.getLabel();
            objResults.put(pControllingLabel,new List<String>());
        }

        for(Integer pDependentIndex = 0; pDependentIndex < dep_ple.size(); pDependentIndex++){

            Schema.PicklistEntry dep_entry = dep_ple[pDependentIndex];
            String pEntryStructure = JSON.serialize(dep_entry);

            Ex2_PickListUtils.PicklistDetails objDepPLE = (Ex2_PickListUtils.PicklistDetails)JSON.deserialize(
                    pEntryStructure,
                    Ex2_PickListUtils.PicklistDetails.class
            );

            for(Integer pControllingIndex = 0; pControllingIndex < ctrl_ple.size(); pControllingIndex++){
                if (objBitSet.fitBit(objDepPLE.validFor, pControllingIndex)){
                    String pControllingLabel = ctrl_ple[pControllingIndex].getLabel();
                    objResults.get(pControllingLabel).add(objDepPLE.label);
                }
            }
        }
        return objResults;
    }
}