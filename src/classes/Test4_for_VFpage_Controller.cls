/**
 * Created by mryzhkouskaya on 18.11.2019.
 */

public class Test4_for_VFpage_Controller {

    public String RecordToDelete {get; set;}
//    public String personID  {get; set;}
    public String inputText{get;set;}
//    public String somevariable{get;set;}

    public PageReference doRedirectToAnotherPage(){


        PageReference pageRef = new PageReference('/apex/Test3_VF_in_Lightning');
        pageRef.setRedirect(true);

//        pageRef.getParameters().put('param2ToTest3page','425');
//        value = ApexPages.currentPage().getParameters().get('inpval');
        system.debug('in redirect');
        system.debug('RecordToDelete'+RecordToDelete);
//                system.debug('personID'+personID);
                system.debug('inputText'+inputText);
//                system.debug('somevariable '+somevariable);

//        pageRef.getParameters().put('paramToTest3page','123');
        pageRef.getParameters().put('param2ToTest3page',inputText);
//        personID = System.currentPageReference().getParameters().get('personID');

        return pageRef;
    }



    public String myParameter1;
    public String myParameter2 ;

//
//    public String getParamsFromPageReference(){
//
//        myParameter1 = ApexPages.currentPage().getParameters().get('paramToTest3page');
//        myParameter2 = ApexPages.currentPage().getParameters().get('param2ToTest3page');
//        System.debug('My parametr '+ myParameter1);
//        System.debug('My parametr '+ myParameter2);
//        System.debug('My parametr '+ 11);
//        return myParameter1;
//    }

    public List<String> collection {
        get {
            if (collection == null) {
                collection = new List<String>();
//                myParameter1 = ApexPages.currentPage().getParameters().get('paramToTest3page');
                myParameter2 = ApexPages.currentPage().getParameters().get('param2ToTest3page');
//                collection.add(myParameter1);
                collection.add(myParameter2);
            }
            return collection;
        }
        private set;
    }

    public void setParamsTpApex(){
System.debug('***');
//        system.debug('somevariable '+somevariable);

    }
}