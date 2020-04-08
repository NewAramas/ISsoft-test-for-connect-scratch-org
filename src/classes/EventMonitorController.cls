/**
 * Created by mryzhkouskaya on 12.12.2019.
 */

public with sharing class EventMonitorController {
    @AuraEnabled
    public static void getUserList() {
//    public static List<selectOption> getUserList(){
//
/////////////hardCode////////
////        String userName = 'Nicolas Cage';
//        String userName = 'Stanislav Sergeev';
////        String userName = 'Team Nicholson';
////        String userName = 'TeamOwner Wilson';
//        String queryUser = 'SELECT Id, Name, ContactId FROM User WHERE Name=:userName LIMIT 1';
//        User user = Database.query(queryUser);
//        String contactIdCurrentCommunityUser = (String)user.get('ContactId');
//        System.debug('contactIdCurrentCommunityUser '+ contactIdCurrentCommunityUser);
//
//        List<Anova_Team__c> listAllAnovaTeams = [SELECT Id, Name, Parent_Anova_Team__c, Team_Owner__c,(SELECT Name FROM Contacts__r)
//        FROM Anova_Team__c
//        LIMIT 1000];
//
//        List<Anova_Team__c> listChildAnovaTeams = new List<Anova_Team__c>();
//        Anova_Team__c currentAnovaTeam = new Anova_Team__c();
//        Map<Id, List<Anova_Team__c>> mapIdParentToChildrenAnovaTeam = new map<Id, List<Anova_Team__c>>();
//
//        for (Anova_Team__c anovaTeamItem : listAllAnovaTeams) {
//            if (anovaTeamItem.Team_Owner__c == contactIdCurrentCommunityUser) {
//                currentAnovaTeam = anovaTeamItem;
//            }
//            if (anovaTeamItem.Parent_Anova_Team__c != null) {
//
//                if (mapIdParentToChildrenAnovaTeam.get(anovaTeamItem.Parent_Anova_Team__c) != null) {
//                    listChildAnovaTeams = mapIdParentToChildrenAnovaTeam.get(anovaTeamItem.Parent_Anova_Team__c);
//                    listChildAnovaTeams.add(anovaTeamItem);
//                    mapIdParentToChildrenAnovaTeam.put(anovaTeamItem.Parent_Anova_Team__c, listChildAnovaTeams);
//                    listChildAnovaTeams = null;
//                } else {
//                    List<Anova_Team__c> newListChildAnovaTeams = new List<Anova_Team__c>();
//                    newListChildAnovaTeams.add(anovaTeamItem);
//                    mapIdParentToChildrenAnovaTeam.put(anovaTeamItem.Parent_Anova_Team__c, newListChildAnovaTeams);
//                }
//            }
//        }
//
//        Map<Anova_Team__c, List<Anova_Team__c>> mapParentToAllChildrenAnovaTeam = new Map<Anova_Team__c, List<Anova_Team__c>>();
//        setAllChildsToAnovaTeamsHierarchyMap( currentAnovaTeam, mapParentToAllChildrenAnovaTeam, mapIdParentToChildrenAnovaTeam);
//
//
//        List<selectOption> optionsList = new List<selectOption>();
//        for (Anova_Team__c anovaTeamItem : mapParentToAllChildrenAnovaTeam.get(currentAnovaTeam)) {
//            if(anovaTeamItem.Contacts__r != NULL) {
//                for(Contact conactItem : anovaTeamItem.Contacts__r){
//                    selectOption option = new selectOption();
//                    option.label = conactItem.Name;
//                    option.value = conactItem.Name;
//                    optionsList.add(option);
//                }
//            }
//        }
//        if(currentAnovaTeam.Contacts__r != NULL) {
//            for (Contact conactItem : currentAnovaTeam.Contacts__r) {
//                selectOption option = new selectOption();
//                option.label = conactItem.Name;
//                option.value = conactItem.Name;
//                optionsList.add(option);
//            }
//        }
////        List<SelectOption> optionsList = EventMonitorService.getUserList();
//
//        return optionsList;
//    }

//    private static List<Anova_Team__c> setAllChildsToAnovaTeamsHierarchyMap(Anova_Team__c parentAnovaTeam, Map<Anova_Team__c,
//            List<Anova_Team__c>> mapParentToAllChildrenAnovaTeam, Map<Id, List<Anova_Team__c>> mapIdParentToChildrenAnovaTeam) {
//
//        List<Anova_Team__c> listAllChildrenAnovaTeams = new List<Anova_Team__c>();
//        List<Anova_Team__c> listChildrenAnovaTeam = mapIdParentToChildrenAnovaTeam.get(parentAnovaTeam.Id);
//
//        if (listChildrenAnovaTeam != null) {
//            mapParentToAllChildrenAnovaTeam.put(parentAnovaTeam, listAllChildrenAnovaTeams);
//            listAllChildrenAnovaTeams.addAll(listChildrenAnovaTeam);
//
//            for (Anova_Team__c child : listChildrenAnovaTeam) {
//                listAllChildrenAnovaTeams.addAll(setAllChildsToAnovaTeamsHierarchyMap(child, mapParentToAllChildrenAnovaTeam,
//                        mapIdParentToChildrenAnovaTeam));
//            }
//        }
//        return listAllChildrenAnovaTeams;
//    }

//        public static List<Anova_Team__c> getAllAnovaTeamsOfCurrentAccount() {
//        List<Anova_Team__c> listAllAnovaTeams = [
//        SELECT Id, Name, Parent_Anova_Team__c, Team_Owner__c, (SELECT Name FROM Contacts__r)
//        FROM Anova_Team__c
//        LIMIT 1000
//        ];
//        return listAllAnovaTeams;
//    }
//}
    }
}