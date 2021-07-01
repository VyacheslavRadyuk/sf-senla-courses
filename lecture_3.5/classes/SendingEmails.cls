public class SendingEmails {
    
    @AuraEnabled
    public static void sendMailToTourist(String mMail, String mSubject, String mbody) {
        EmailService.sendMailToTourist(mMail, mSubject, mbody);
    }
}