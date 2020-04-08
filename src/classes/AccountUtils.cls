public class AccountUtils {
    public static List<Account> accountsByState(String state){
        List<Account> lstAccounts = [SELECT Id, Name FROM Account WHERE billingState =: state];
        System.debug('@@'+ lstAccounts);
        return lstAccounts;
    }
}