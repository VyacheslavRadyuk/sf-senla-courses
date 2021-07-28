global class EmailToLead implements Messaging.InboundEmailHandler {  
    public static final String companyName = 'from email';
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                           Messaging.InboundEnvelope env){ 
                                                               
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();      
        String myPlainText= '';       
        myPlainText = email.plainTextBody;
        
        List<Lead> leads = [SELECT Id, Name, Email
                            FROM Lead
                            WHERE Email = :email.fromAddress];
        
        if (leads.size() == 0) {            
            Lead newLead = new Lead(Email = email.fromAddress, 
                                    LastName = email.fromName, 
                                    Company = companyName,                                                                                      
                                    Description = myPlainText
                                   );
            insert newLead;
        }
        
        return result;
    }
}