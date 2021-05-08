global class DeleteFlightsBatch implements Database.Batchable<sObject>, Database.Stateful, Database.RaisesPlatformEvents {   
    private Map<Id, Integer> mapTourists = new Map<Id, Integer>();
    
    global Database.QueryLocator start(Database.BatchableContext bc) {    
        return Database.getQueryLocator('SELECT Id, ' + 
                                        'SecondStatus__c, ' + 
                                        'CreatedDate, ' +
                                        'Tourist__c ' +
                                        'FROM Flight__c ' +
                                        'WHERE SecondStatus__c = \'' + Constants.FLIGHT_STATUS_DECLINED + '\'' +  
                                        'AND CreatedDate = LAST_N_DAYS:' + Constants.FLIGHT_DELETION_PERIOD + ''
                                       );
    }  
    
    global void execute(Database.BatchableContext bc, List<Flight__c> flights) {   
        for(Flight__c flight : flights) {
            Integer count = 1;
            
            if (!mapTourists.containsKey(flight.Tourist__c)) {
                mapTourists.put(flight.Tourist__c, count);
            } else {  
                count = mapTourists.get(flight.Tourist__c) + 1;
                mapTourists.put(flight.Tourist__c, count);
            }
        }     
        delete flights;   
        DataBase.emptyRecycleBin(flights);
    }
    
    global void finish(Database.BatchableContext bc) {   
        EmailService.sendEmailMessage(mapTourists);
    }
}