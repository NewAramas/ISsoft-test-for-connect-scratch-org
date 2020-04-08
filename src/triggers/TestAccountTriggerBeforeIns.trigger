/**
 * Created by mryzhkouskaya on 13.03.2020.
 */

trigger TestAccountTriggerBeforeIns on Account (before insert) {
    System.debug('In trigger before insert use ');
//    for(Account a:Trigger.new){
//        Contact c = new Contact();

//    }

}