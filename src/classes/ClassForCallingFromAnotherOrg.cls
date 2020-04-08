/**
 * Created by mryzhkouskaya on 24.01.2020.
 */
@RestResource(urlMapping='/Account/*')
global with sharing class ClassForCallingFromAnotherOrg {

    @HttpDelete
    global static void doDelete()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId]; delete account;
    }
    @HttpGet
    global static Account doGet()
    {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account result = [SELECT Id, Name, Phone, Website FROM Account WHERE Id = :accountId];
        return result;
    }
    @HttpPost
    global static String doPost(String name, String phone, String website)
    {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }

//    webservice static void getAllChildren(Id idOfCurrentFigure) {
//
//            List<Figure__c> listOfAllFigures = [SELECT Id, ParentFigure__c FROM Figure__c];
//            List<Figure__c> listChildFigures = new List<Figure__c>();
//            Figure__c currentFigure = new Figure__c();
//            Map<Id, List<Figure__c>> mapIdParentToChildrenFigures = new Map<Id, List<Figure__c>>();
//            Map<Figure__c, List<Figure__c>> mapParentToAllChildrenFigures = new Map<Figure__c, List<Figure__c>>();
//
//            if (listOfAllFigures.size() != 0) {
//                for (Figure__c figureItem : listOfAllFigures) {
//                    if (figureItem.Id == idOfCurrentFigure) {
//                        currentFigure = figureItem;
//                    }
//                    if (figureItem.ParentFigure__c != null) {
//                        if (mapIdParentToChildrenFigures.get(figureItem.ParentFigure__c) != null) {
//                            listChildFigures = mapIdParentToChildrenFigures.get(figureItem.ParentFigure__c);
//                            listChildFigures.add(figureItem);
//                            mapIdParentToChildrenFigures.put(figureItem.ParentFigure__c, listChildFigures);
//                            listChildFigures = null;
//                        } else {
//                            List<Figure__c> newListChildFigures = new List<Figure__c>();
//                            newListChildFigures.add(figureItem);
//                            mapIdParentToChildrenFigures.put(figureItem.ParentFigure__c, newListChildFigures);
//                        }
//                    }
//                }
//                recursiveMethod(currentFigure, mapParentToAllChildrenFigures, mapIdParentToChildrenFigures);
//
////            return (mapParentToAllChildrenFigures, currentFigure);
//            } else {
////            return null;
//            }
//        }
//
//
//
//        private static List<Figure__c> recursiveMethod(Figure__c parentFigure, Map<Figure__c,
//                List<Figure__c>> mapParentToAllChildrenFigures, Map<Id, List<Figure__c>> mapIdParentToChildrenFigures) {
//
//            List<Figure__c> listAllChildrenFigures = new List<Figure__c>();
//            List<Figure__c> listChildrenFigures = mapIdParentToChildrenFigures.get(parentFigure.Id);
//
//            if (listChildrenFigures != null) {
//                mapParentToAllChildrenFigures.put(parentFigure, listAllChildrenFigures);
//                listAllChildrenFigures.addAll(listChildrenFigures);
//
//                for (Figure__c child : listChildrenFigures) {
//                    listAllChildrenFigures.addAll(recursiveMethod(child, mapParentToAllChildrenFigures,
//                            mapIdParentToChildrenFigures));
//                }
//            }
//
//            return listAllChildrenFigures;
//        }
////        List<Figure__c> listChildrenFigures = new List<Figure__c>();
////        for (Figure__c child : parent.getChildren()) {
////            result.update(process(child));
////        }
////        return result;


    }