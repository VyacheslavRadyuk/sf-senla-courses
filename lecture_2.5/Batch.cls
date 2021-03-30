global class Batch implements Database.Batchable<sObject>, Database.Stateful {
    Integer j = 1;
    Integer i = 1;
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
            
            if (!mapTourists.containsKey(a.Tourist__c)) {
                mapTourists.put(a.Tourist__c, i);
            } else {
                mapTourists.put(a.Tourist__c, i + j);
            }
        }     
        delete scope;   
        DataBase.emptyRecycleBin(scope); 
        system.debug(mapTourists);
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
        mail.setPlainTextBody('Туристы и количество отмененных рейсов для каждого из них: ' + mapTourists);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}