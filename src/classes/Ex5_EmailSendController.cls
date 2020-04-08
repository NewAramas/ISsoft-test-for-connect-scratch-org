/**
 * Created by mryzhkouskaya on 22.10.2019.
 */

public with sharing class Ex5_EmailSendController {
    @AuraEnabled
    public static void sendMailMethod(String mMail ,String mSubject ,String mbody){
        System.debug('mMail'+mMail);
        System.debug('mSubject'+mSubject);
        System.debug('mbody'+mbody);

        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();

        // Step 1: Create a new Email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

        // Step 2: Set list of people who should get the email
//        List<String> sendTo = new List<String>();
//        sendTo.add(mMail);
        String[] toAddresses = new String[] {mMail};
        mail.setToAddresses(toAddresses);
System.debug('1');
        // Step 3: Set who the email is sent from
        mail.setReplyTo('margushanew@gmail.com'); // change it with your mail address.
//        mail.setSenderDisplayName('salesforce User');
        System.debug('2');
        // Step 4. Set email contents - you can use variables!
        mail.setSubject(mSubject);
        mail.setHtmlBody(mbody);
        System.debug('3');
        // Step 5. Add your email to the master list
        mails.add(mail);
        System.debug('4');

        // Step 6: Send all emails in the master list
//        Messaging.sendEmail(mails);
        //margushanew@gmail.com


        String sMessage='';
        try{
//            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
//            String[] toAddresses = new String[] {email};
//            mail.setToAddresses(toAddresses);
//            mail.setSubject(Subject);
//            mail.setHtmlBody(Message);
            System.debug('5');
            Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            sMessage='Success';
            System.debug('6');
        }
        catch(Exception ex){
            sMessage=ex.getLineNumber()+'\n'+ex.getCause()+'\n'+ex.getMessage()+'\n'+ex.getStackTraceString();
            System.debug('sMessage'+ sMessage);
        }
//        return sMessage;
    }
}