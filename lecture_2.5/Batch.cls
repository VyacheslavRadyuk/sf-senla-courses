global class Batch implements Database.Batchable<sObject>, Database.Stateful {
    
    Integer i = 0;
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
            mapTourists.put(a.Tourist__c, i++);
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
        mail.setPlainTextBody('Турист: ' + mapTourists.keySet() + 'Количество: ' + mapTourists.values());
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}