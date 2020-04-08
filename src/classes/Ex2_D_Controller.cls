/**
 * Created by mryzhkouskaya on 14.06.2019.
 */

public with sharing class Ex2_D_Controller {
    @AuraEnabled
    public static String getDependencyValues(String controllingField, String dependentField) {
System.debug('controlingField' + controllingField);
System.debug('dependentField' + dependentField);
        Map<String,List<String>> pickValueMap =
                Ex2_DependentPickListValueController.GetDependentOptions('Contact',controllingField,dependentField);
        String result = JSON.serialize(pickValueMap);
        return result;
    }
}