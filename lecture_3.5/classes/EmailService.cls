public class EmailService {
    
    public static void sendEmailMessage(Map<Id, Integer> mapTourists) {
        List<Email__mdt> emailSetting = MetadataManager.getEmail();
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String> {emailSetting[0].Email__c};
            mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.MAIL_SUBJECT);
        String linkToHtml = '';
        
        for (Id touristId : mapTourists.keySet()) {
            Integer valueById = mapTourists.get(touristId);
            linkToHtml += '<a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + touristId + '">"' 
                + touristId + '"</a>' + ' : ' + valueById + '<br>';
        }
        mail.setHtmlBody(Constants.MAIL_HTML_BODY + ' ' + '<br>' + linkToHtml);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });       
    }
    
    public static void sendMailToTourist(String mMail, String mSubject, String mbody) {
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
       		message.toAddresses = new String[] {mMail};
        	message.subject = mSubject;
        	message.plainTextBody = mbody;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
}