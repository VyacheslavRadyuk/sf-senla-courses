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
}