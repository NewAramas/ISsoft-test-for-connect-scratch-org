/**
 * Created by mryzhkouskaya on 28.05.2019.
 */

public class SPsortRecords{

    @AuraEnabled
    public static List<String> sortListOfValues(List<Object> listOfValues, String fieldAPIName) {

//        if (!listOfValues.isEmpty()) {
//            String objectName = listOfValues.get(0)..getSObjectType().getDescribe().getName();
//            if (objectName != null) {
//                System.debug('Object name ', objectName);
//
//                for (Object objectExemplar : listOfValues) {
//                }
//            }
//        }
        return null;


//        List<String> listOfString = new List<String>();
//        listOfString.add('1');
//        listOfString.add('111');
//        listOfString.add('2');
//        listOfString.add('222');
//        listOfString.add('3');
//
//        listOfString.sort();
//        for (String str : listOfString) {
//            System.debug('STR ' + str);
//        }
    }


    @AuraEnabled
    public static List<SObject> sortRecords(String fieldName, List<SObject> records){
        System.debug('IN DEBUG line 81');
        return records;
    }

//    global Integer compareTo(Object compareTo) {
//        return null;
//    }
}