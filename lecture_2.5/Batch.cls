global class Batch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {
    
    Map<Id, Integer> mapTourists = new Map<Id, Integer>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) { 
        
        return Database.getQueryLocator('SELECT id, ' + 
                                        'SecondStatus__c, ' + 
                                        'CreatedDate, ' +
                                        'Tourist__c ' +
                                        'FROM Flight__c ' +
                                        'WHERE SecondStatus__c = \'Declined\' ' +  
                                        'AND CreatedDate = LAST_N_DAYS:1'
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
        
        Email__mdt a = [SELECT Id, 
                        Email__c
                        FROM Email__mdt 
                       ];
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.Email__c};
            mail.setToAddresses(toAddresses);
        mail.setSubject('Batch was completed');
        String linkToHtml = '';
        
        for (Id b : mapTourists.keySet()) {
            Integer valueById = mapTourists.get(b);
            linkToHtml += '<a href="' + URL.getSalesforceBaseUrl().toExternalForm() + '/' + b + '">"' 
                + b + '"</a>' + ' : ' + valueById + '<br>';
        }
        mail.setHtmlBody('Туристы и количество отмененных рейсов для каждого из них: ' + '<br>' + linkToHtml);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}