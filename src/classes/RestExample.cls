/**
 * Created by Lenovo on 14.03.2020.
 */

@RestResource(UrlMapping='/test/*')
global with sharing class RestExample {
    @HttpGet
    global static Id getText() {
        Contact con = new Contact();
        con.LastName = '123';
        insert con;
        return con.Id;
//        return 'Test111';
    }

    @HttpPost
    global static Id createContact(String contactName){
        Contact con = new Contact();
        con.LastName = contactName;
        insert con;
        return con.Id;
    }
}