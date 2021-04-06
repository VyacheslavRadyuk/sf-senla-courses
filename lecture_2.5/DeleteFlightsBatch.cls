global class DeleteFlightsBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {   
    Map<Id, Integer> mapTourists = new Map<Id, Integer>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) { 
        
        return Database.getQueryLocator('SELECT Id, ' + 
                                        'SecondStatus__c, ' + 
                                        'CreatedDate, ' +
                                        'Tourist__c ' +
                                        'FROM Flight__c ' +
                                        'WHERE SecondStatus__c = \'' + Constants.APP_STATUS_ACTIVE + '\'' +  
                                        'AND CreatedDate != LAST_N_DAYS:' + Constants.LAST_N_DAYS + ''
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
        EmailService.sendEmailMessage(mapTourists);
    }
}