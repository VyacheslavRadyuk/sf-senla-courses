global class DeleteFlightsBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {   
    Map<Id, Integer> mapTourists = new Map<Id, Integer>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) { 
        
        return Database.getQueryLocator('SELECT Id, ' + 
                                        'SecondStatus__c, ' + 
                                        'CreatedDate, ' +
                                        'Tourist__c ' +
                                        'FROM Flight__c ' +
                                        'WHERE SecondStatus__c = \'' + Constants.FLIGHT_STATUS_DECLINED + '\'' +  
                                        'AND CreatedDate != LAST_N_DAYS:' + Constants.FLIGHT_DELETION_PERIOD + ''
                                       );
    } 
    
    global void execute(Database.BatchableContext BC, List<Flight__c> scope) {
        
        for(Flight__c record : scope) {
            Integer count = 1;
            
            if (!mapTourists.containsKey(record.Tourist__c)) {
                mapTourists.put(record.Tourist__c, count);
            } else {  
                count = mapTourists.get(record.Tourist__c) + 1;
                mapTourists.put(record.Tourist__c, count);
            }
        }     
        delete scope;   
        DataBase.emptyRecycleBin(scope);
    }
    
    global void finish(Database.BatchableContext BC) {   
        EmailService.sendEmailMessage(mapTourists);
    }
}