/**
 * Created by mryzhkouskaya on 28.01.2020.
 */
@IsTest
public with sharing class RecursionTest {
    @IsTest
    static void test_getFactorial() {
        Integer result = Recursion.getFactorial(5);
        System.debug(result);
        System.assertEquals(120, result);
    }

    @IsTest
    static void test_getFibonacci() {
        Integer result = Recursion.getFibonacci(6);
        System.debug(result);
        System.assertEquals(8, result);

    }

    @IsTest
    static void test_getSimplesMultipliers() {
        Recursion.getSimplesMultipliers(4356);
    }
    @IsTest
    static void test_restApi() {
        System.debug(UserInfo.getSessionId().SubString(15));

//        Recursion.restApi();
    }
}