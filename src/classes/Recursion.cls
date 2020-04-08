/**
 * Created by mryzhkouskaya on 28.01.2020.
 */

public with sharing class Recursion {

    public static void restApi() {

        String sfdcURL = URL.getSalesforceBaseUrl().toExternalForm();
        System.debug(UserInfo.getSessionId());
        String restAPIURL = sfdcURL + '/services/data/v29.0/sobjects/';

//        HttpRequest httpRequest = new HttpRequest();
//        httpRequest.setMethod('GET');
//        httpRequest.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
//        httpRequest.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
//        httpRequest.setEndpoint(restAPIURL);
//        String response = '';
//        try {
//            Http http = new Http();
//            HttpResponse httpResponse = http.send(httpRequest);
//            if (httpResponse.getStatusCode() == 200 ) {
//                response = JSON.serializePretty( JSON.deserializeUntyped(httpResponse.getBody()) );
//            } else {
//                System.debug(' httpResponse ' + httpResponse.getBody() );
//                throw new CalloutException( httpResponse.getBody() );
//            }
//        } catch( System.Exception e) {
//            System.debug('ERROR: '+ e);
//            throw e;
//        }
//        System.debug(' ** response ** : ' + response );
    }

    public static Integer getFactorial(Integer numberForGettingFactorial) {

        if(numberForGettingFactorial == 1){
           return 1;
        }
        return numberForGettingFactorial * getFactorial(numberForGettingFactorial - 1);
    }

    public static Integer getFibonacci(Integer position) {

        if(position == 1 || position == 2){
            return 1;
        }
        return  getFibonacci(position - 1) + getFibonacci(position - 2);
    }

    public static Integer getSimplesMultipliers(Integer numberForGetMultipliers) {

        if (numberForGetMultipliers > 0) {

            List<Double> listDivisionsIdentifiedByDividingOn2 = new List<Double>();
            List<Double> listDivisionsIdentifiedByDividingOn3 = new List<Double>();
            List<Double> listDivisionsIdentifiedByDividingOn5 = new List<Double>();
            List<Double> listDivisionsIdentifiedByDividingOn7 = new List<Double>();
            List<Double> listDivisionsIdentifiedByDeterminingSQRT = new List<Double>();
            Set<Double> setAllDivisions = new Set<Double>();

            List<Integer> listForCombinations = new List<Integer>();
            Set<Double> setDividers = new Set<Double>();

            Wrapper wrapper = new Wrapper();
// definition initial value on sqrt
            if (numberForGetMultipliers != 1.0) {
                wrapper.amountOfDivider = 0;
                wrapper.numberForDevision = numberForGetMultipliers;
                doSQRTOfNumber(numberForGetMultipliers, listDivisionsIdentifiedByDeterminingSQRT);
                if (!listDivisionsIdentifiedByDeterminingSQRT.isEmpty()) {
                    setAllDivisions.addAll(listDivisionsIdentifiedByDeterminingSQRT);
                    System.debug('-корень * ' + listDivisionsIdentifiedByDeterminingSQRT);
                }
            }

// definition  simple numbers on result
            wrapper.amountOfDivider = 0;
            wrapper.numberForDevision = numberForGetMultipliers;
            doDivisionOnDivider(wrapper, 2, listDivisionsIdentifiedByDividingOn2);
            doDivisionOnDivider(wrapper, 3, listDivisionsIdentifiedByDividingOn3);
            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn3);
            doDivisionOnDivider(wrapper, 5, listDivisionsIdentifiedByDividingOn5);
            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn5);
            doDivisionOnDivider(wrapper, 7, listDivisionsIdentifiedByDividingOn7);
            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn7);
            setDividers.add(wrapper.numberForDevision);

//definition final result on sqrt
            Double sqrtFromFinalResultOfDevisions ;
            if (wrapper.numberForDevision != 1.0) {
                sqrtFromFinalResultOfDevisions = doSQRTOfNumber(wrapper.numberForDevision, listDivisionsIdentifiedByDeterminingSQRT);
                setAllDivisions.add(sqrtFromFinalResultOfDevisions);
                listForCombinations.add((Integer) sqrtFromFinalResultOfDevisions);
                setDividers.add(sqrtFromFinalResultOfDevisions);
            }
// definition dividers dividing on 2,3,5,7
            definitionDividers(wrapper, numberForGetMultipliers, listDivisionsIdentifiedByDividingOn2, (Double) 2, sqrtFromFinalResultOfDevisions,
                    listForCombinations, setAllDivisions, setDividers);
            definitionDividers(wrapper, numberForGetMultipliers, listDivisionsIdentifiedByDividingOn3, (Double) 3, sqrtFromFinalResultOfDevisions,
                    listForCombinations, setAllDivisions, setDividers);
            definitionDividers(wrapper, numberForGetMultipliers, listDivisionsIdentifiedByDividingOn5, (Double) 5, sqrtFromFinalResultOfDevisions,
                    listForCombinations, setAllDivisions, setDividers);
            definitionDividers(wrapper, numberForGetMultipliers, listDivisionsIdentifiedByDividingOn7, (Double) 7, sqrtFromFinalResultOfDevisions,
                    listForCombinations, setAllDivisions, setDividers);


            Integer size = listForCombinations.size();
            for (Integer i = size - 1; i > 0; i--) {
                setDividers.add((Double) (listForCombinations.get(i) * listForCombinations.get(i - 1)));
                if (i - 2 >= 0) {
                    setDividers.add((Double) (listForCombinations.get(i) * listForCombinations.get(i - 2)));
                    if (i - 3 >= 0) {
                        setDividers.add((Double) (listForCombinations.get(i) * listForCombinations.get(i - 3)));
                        if (i - 4 >= 0) {
                            setDividers.add((Double) (listForCombinations.get(i) * listForCombinations.get(i - 4)));
                        }
                    }
                }
            }
            setAllDivisions.addAll(setDividers);

            wrapper.amountOfDivider = 0;
            wrapper.numberForDevision = numberForGetMultipliers;
            List<Double> listDivisionsIdentifiedByDividingOnXX = new List<Double>();

            for(Double divider : setDividers) {
                wrapper.amountOfDivider = 0;
                wrapper.numberForDevision = numberForGetMultipliers;
                if (divider != 1.0) {
                    doDivisionOnDivider(wrapper, (Integer) divider, listDivisionsIdentifiedByDividingOnXX);
                }
            }
            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOnXX);

// definition  simple numbers
            for(Integer divider = 4; divider < Math.sqrt(numberForGetMultipliers); divider++){
                if(!setAllDivisions.contains((Double)divider)){
                    Double resultOfDividedByDivider = numberForGetMultipliers / (Double)divider;
                    Double roundedResultOfDividedByDivider = (Double)resultOfDividedByDivider.round();
                    if(roundedResultOfDividedByDivider == resultOfDividedByDivider){
                        setAllDivisions.add(divider);
                        setAllDivisions.add(resultOfDividedByDivider);
                    }
                }
            }

            System.debug('-----------------------------------');
            System.debug(setAllDivisions);
            System.debug('-----------------------------------');

            for (Double divider : setAllDivisions) {
                System.debug('**' + divider);
            }
        }
        return null;
    }

    private static Double doSQRTOfNumber(Double numberForDefineSQRT, List<Double> listDivisionsIdentifiedByDeterminingSQRT) {

        Double resultOfDeterminingSQRT = Math.sqrt(numberForDefineSQRT);
        Long roundedResultOfDeterminingSQRT = resultOfDeterminingSQRT.round();

        if(roundedResultOfDeterminingSQRT == resultOfDeterminingSQRT){
            listDivisionsIdentifiedByDeterminingSQRT.add(resultOfDeterminingSQRT);
            return  doSQRTOfNumber(resultOfDeterminingSQRT, listDivisionsIdentifiedByDeterminingSQRT);
        } else {
            return numberForDefineSQRT;
        }
    }

    private static Wrapper doDivisionOnDivider(Wrapper wrapper, Integer divider, List<Double> listDivisionsIdentifiedByDividingOnDivider) {

        Double resultOfDividedByDivider = wrapper.numberForDevision / divider;
        Long roundedResultOfDividedByDivider = resultOfDividedByDivider.round();

        if(roundedResultOfDividedByDivider == resultOfDividedByDivider){
            listDivisionsIdentifiedByDividingOnDivider.add(resultOfDividedByDivider);
            wrapper.numberForDevision = resultOfDividedByDivider;
            wrapper.amountOfDivider ++;
            return  doDivisionOnDivider(wrapper, divider, listDivisionsIdentifiedByDividingOnDivider);
        } else {
            return wrapper;
        }
    }

    private static void definitionDividers(Wrapper wrapper, Double numberForGetMultipliers, List<Double> listDivisionsIdentifiedByDividingOnX,
            Double divider, Double sqrtFromFinalResultOfDevisions, List<Integer> listForCombinations, Set<Double> setAllDivisions,
            Set<Double> setDividers) {

        wrapper.amountOfDivider = 0;
        wrapper.numberForDevision = numberForGetMultipliers;
        doDivisionOnDivider(wrapper, (Integer)divider, listDivisionsIdentifiedByDividingOnX);
        if(!listDivisionsIdentifiedByDividingOnX.isEmpty()){
            listForCombinations.add((Integer)divider);
            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOnX);
            setAllDivisions.add(divider);
            if(wrapper.numberForDevision > 0){
                for(Integer i=1; i<= wrapper.amountOfDivider; i++) {
                    Double numberInDegree = Math.pow(divider,i);
                    setAllDivisions.add(numberInDegree);
                }
            }
        }
    }

    class Wrapper{
        Double numberForDevision;
        Integer amountOfDivider;
    }

}

//        wrapper.amountOfDivider = 0;
//        wrapper.numberForDevision = numberForGetMultipliers;
//        doDivisionOnDivider(wrapper, 2, listDivisionsIdentifiedByDividingOn2);
//        if (!listDivisionsIdentifiedByDividingOn2.isEmpty()) {
//            listForCombinations.add(2);
//            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn2);
//            setAllDivisions.add((Double)2.00);
//            if(wrapper.numberForDevision > 0){
//                for(Integer i=0; i<= wrapper.amountOfDivider; i++) {
//                    Double numberInDegree = (Double)2.00.pow(i);
//                    setAllDivisions.add(numberInDegree);
//                    setDividers.add( numberInDegree*sqrtFromFinalResultOfDevisions);
//                }
//            }
//        }
//
//        wrapper.amountOfDivider = 0;
//        wrapper.numberForDevision = numberForGetMultipliers;
//        doDivisionOnDivider(wrapper, 3, listDivisionsIdentifiedByDividingOn3);
//        if (!listDivisionsIdentifiedByDividingOn3.isEmpty()) {
//            listForCombinations.add(3);
//            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn3);
//            setAllDivisions.add((Double)3.00);
//            if(wrapper.numberForDevision > 0){
//                for(Integer i=0; i<= wrapper.amountOfDivider; i++) {
//                    Double numberInDegree = (Double)3.00.pow(i);
//                    setAllDivisions.add(numberInDegree);
//                    setDividers.add( numberInDegree*sqrtFromFinalResultOfDevisions);
//                }
//            }
//        }
//
//        wrapper.amountOfDivider = 0;
//        wrapper.numberForDevision = numberForGetMultipliers;
//        doDivisionOnDivider(wrapper, 5, listDivisionsIdentifiedByDividingOn5);
//        if(!listDivisionsIdentifiedByDividingOn5.isEmpty()){
//            listForCombinations.add(5);
//            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn5);
//            setAllDivisions.add((Double)5.00);
//            if(wrapper.numberForDevision > 0){
//                for(Integer i=0; i<= wrapper.amountOfDivider; i++) {
//                    Double numberInDegree = (Double)5.00.pow(i);
//                    setAllDivisions.add(numberInDegree);
//                    setDividers.add( numberInDegree*sqrtFromFinalResultOfDevisions);
//                }
//            }
//        }
//
//        wrapper.amountOfDivider = 0;
//        wrapper.numberForDevision = numberForGetMultipliers;
//        doDivisionOnDivider(wrapper, 7, listDivisionsIdentifiedByDividingOn7);
//        if(!listDivisionsIdentifiedByDividingOn7.isEmpty()){
//            listForCombinations.add(7);
//            setAllDivisions.addAll(listDivisionsIdentifiedByDividingOn7);
//            setAllDivisions.add((Double)7.00);
//            if(wrapper.numberForDevision > 0){
//                for(Integer i=0; i<= wrapper.amountOfDivider; i++) {
//                    Double numberInDegree = (Double)7.00.pow(i);
//                    setAllDivisions.add(numberInDegree);
//                    setDividers.add( numberInDegree*sqrtFromFinalResultOfDevisions);
//                }
//            }
//        }
//////////////////////////////

//    public static Double doDivisionOn2(Double numberForDevision, List<Double> listDivisionsIdentifiedByDividingOn2) {
//
//        Double resultOfDividedBy2 = numberForDevision / 2;
//        Long roundedResultOfDividedBy2 = resultOfDividedBy2.round();
//
//        if(roundedResultOfDividedBy2 == resultOfDividedBy2){
//            listDivisionsIdentifiedByDividingOn2.add(resultOfDividedBy2);
//            return  doDivisionOn2(resultOfDividedBy2, listDivisionsIdentifiedByDividingOn2);
//        } else {
//            return numberForDevision;
//        }
//    }
//
//    public static Double doDivisionOn3(Double numberForDevision, List<Double> listDivisionsIdentifiedByDividingOn3) {
//
//        Double resultOfDividedBy3 = numberForDevision / 3;
//        Long roundedResultOfDividedBy3 = resultOfDividedBy3.round();
//
//        if(roundedResultOfDividedBy3 == resultOfDividedBy3){
//            listDivisionsIdentifiedByDividingOn3.add(resultOfDividedBy3);
//            return  doDivisionOn3(resultOfDividedBy3, listDivisionsIdentifiedByDividingOn3);
//        } else {
//            return numberForDevision;
//        }
//    }
//
//    public static Double doDivisionOn5(Double numberForDevision, List<Double> listDivisionsIdentifiedByDividingOn5) {
//
//        Double resultOfDividedBy5 = numberForDevision / 5;
//        Long roundedResultOfDividedBy5 = resultOfDividedBy5.round();
//
//        if(roundedResultOfDividedBy5 == resultOfDividedBy5){
//            listDivisionsIdentifiedByDividingOn5.add(resultOfDividedBy5);
//            return  doDivisionOn5(resultOfDividedBy5, listDivisionsIdentifiedByDividingOn5);
//        } else {
//            return numberForDevision;
//        }
//    }
//
//    public static Double doDivisionOn7(Double numberForDevision, List<Double> listDivisionsIdentifiedByDividingOn7) {
//
//        Double resultOfDividedBy7 = numberForDevision / 7;
//        Long roundedResultOfDividedBy7 = resultOfDividedBy7.round();
//
//        if(roundedResultOfDividedBy7 == resultOfDividedBy7){
//            listDivisionsIdentifiedByDividingOn7.add(resultOfDividedBy7);
//            return  doDivisionOn7(resultOfDividedBy7, listDivisionsIdentifiedByDividingOn7);
//        } else {
//            return numberForDevision;
//        }
//    }


//        Double sqrtFromNumber = Math.sqrt(numberForGetMultipliers);
//        Long roundedSqrtFromNumber = sqrtFromNumber.round();
//        System.debug(roundedSqrtFromNumber);
/*   if(roundedSqrtFromNumber == sqrtFromNumber){

       System.debug('Корень найден');
   } else {

       System.debug('Корень не найден');
   }*/


//        Double sqrtFromFinalResultOfDevisions = Math.sqrt(resultOfDividedBy7);
//        Long roundedSqrtFromFinalResultOfDevisions = sqrtFromFinalResultOfDevisions.round();
//        if(roundedSqrtFromFinalResultOfDevisions == sqrtFromFinalResultOfDevisions) {
//            System.debug('++' + sqrtFromFinalResultOfDevisions);
//            listAllDivisions.add()
//        }


//        doDivisionOn2(numberForGetMultipliers, listDivisionsIdentifiedByDividingOn2);
//        doDivisionOn3(numberForGetMultipliers, listDivisionsIdentifiedByDividingOn3);
//        doDivisionOn5(numberForGetMultipliers, listDivisionsIdentifiedByDividingOn5);
//        doDivisionOn7(numberForGetMultipliers, listDivisionsIdentifiedByDividingOn7);

//        Double resultOfDividedBy2 = doDivisionOn2(numberForGetMultipliers, listDivisionsIdentifiedByDividingOn2);
//        Double resultOfDividedBy3 = doDivisionOn3(resultOfDividedBy2, listDivisionsIdentifiedByDividingOn3);
//        Double resultOfDividedBy5 = doDivisionOn5(resultOfDividedBy3, listDivisionsIdentifiedByDividingOn5);
//        Double resultOfDividedBy7 = doDivisionOn7(resultOfDividedBy5, listDivisionsIdentifiedByDividingOn7);