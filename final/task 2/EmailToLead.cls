global class EmailToLead implements Messaging.InboundEmailHandler {  
    public static string companyName = 'from email';
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                           Messaging.InboundEnvelope env){
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
                                                               
        String myPlainText= '';       
        myPlainText = email.plainTextBody;
        
        Lead newLead = new Lead(Email = email.fromAddress, 
                                LastName = email.fromName, 
                                Company = companyName,                                                                                      
                                Description = myPlainText
                               );
        
        insert newLead;      
        return result;
    }
}