public class EmailService {
    
    public static void sendEmailMessage(Map<Id, Integer> mapTourists) {
        Email__mdt getMail = MetadataManager.getEmail();
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        List<String> toAddresses = new List<String> {getMail.Email__c};
        mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.MAIL_SUBJECT);
        String linkToHtml = '';
        
        for (Id b : mapTourists.keySet()) {
            Integer valueById = mapTourists.get(b);
            linkToHtml += '<a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + b + '">"' 
                + b + '"</a>' + ' : ' + valueById + '<br>';
        }
        mail.setHtmlBody(Constants.MAIL_HTML_BODY + ' ' + '<br>' + linkToHtml);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });       
    }
}