global class DeleteFlightsBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {   
    Map<Id, Integer> mapTourists = new Map<Id, Integer>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) { 
        
        return Database.getQueryLocator('SELECT Id, ' + 
                                        'SecondStatus__c, ' + 
                                        'CreatedDate, ' +
                                        'Tourist__c ' +
                                        'FROM Flight__c ' +
                                        'WHERE SecondStatus__c = \'Constants.FLIGHT_STATUS_DECLINED\' ' +  
                                        'AND CreatedDate != LAST_N_DAYS:Constants.LAST_N_DAYS'
                                       );
    } 
    
    global void execute(Database.BatchableContext BC, List<Flight__c> scope) {
        
        for(Flight__c a : scope) {
            Integer count = 1;
            
            if (!mapTourists.containsKey(a.Tourist__c)) {
                mapTourists.put(a.Tourist__c, count);
            } else {  
                count = mapTourists.get(a.Tourist__c) + 1;
                mapTourists.put(a.Tourist__c, count);
            }
        }     
        delete scope;   
        DataBase.emptyRecycleBin(scope);
    }
    
    global void finish(Database.BatchableContext BC) {  
        
        Email__mdt getMail = [SELECT Id, 
                        Email__c
                        FROM Email__mdt 
                       ];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {getMail.Email__c};
            mail.setToAddresses(toAddresses);
        mail.setSubject(Constants.MAIL_SUBJECT);
        String linkToHtml = '';
        
        for (Id b : mapTourists.keySet()) {
            Integer valueById = mapTourists.get(b);
            linkToHtml += '<a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + b + '">"' 
                + b + '"</a>' + ' : ' + valueById + '<br>';
        }
        mail.setHtmlBody('Constants.MAIL_HTML_BODY ' + '<br>' + linkToHtml);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}