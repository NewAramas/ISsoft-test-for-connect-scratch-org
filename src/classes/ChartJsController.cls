/**
 * Created by mryzhkouskaya on 20.02.2020.
 */

public with sharing class ChartJsController {
    @AuraEnabled
    Public static list<charWrap> getChartData(){



        charWrap cWrap1 = new charWrap();
        cWrap1.dataLabels = new list<String>{'Red', 'Orange', 'Yellow', 'Green', 'Blue'};
        cWrap1.dataValues = new list<Integer>{61, 45, 30, 88, 37};

        charWrap cWrap2 = new charWrap();
        cWrap2.dataLabels = new list<String>{'Mango', 'Pineapple', 'Apple', 'Banana', 'Grape'};
        cWrap2.dataValues = new list<Integer>{37, 88, 30, 45, 61};

        return new list<charWrap>{cWrap1, cWrap2};



    }

    public class charWrap {

        @AuraEnabled  public list<string> dataLabels;
        @AuraEnabled  public list<integer> dataValues;

        public charWrap(){
            dataLabels = new list<string>();
            dataValues = new list<integer>();

        }
    }
}