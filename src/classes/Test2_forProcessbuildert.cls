/**
 * Created by mryzhkouskaya on 15.11.2019.
 */

public class Test2_forProcessbuildert {
    @InvocableMethod(label='Create Account2 From Apex' description='')
    public static void createAccount() {
        Account testAccount = new Account();
        testAccount.Name = 'testAccFromApex';
        insert testAccount;
    }
}