public class TouristTriggerHandler {
    
    public static void onBeforeInsert(List<Tourist__c> newTourists, Set<Id> newIds) {
        TouristService.markDuplicates(newTourists, newIds);
    }
    
    public static void afterUpdate (Map<Id, Tourist__c> oldMap, List<Tourist__c> checkActiveFields) {
        
        Set<Id> ids = new Set<Id>();
        
        for (Tourist__c a : checkActiveFields) {
            ids.add(a.Id);
        }
        List<Flight__c> idsDb = FlightManager.getByTouristsId(ids);        
        
        if (idsDb == null || idsDb.isEmpty()) return;
        
        List<flight__c> modifiedSecondStatus = new List<flight__c>();
        
        for (Tourist__c a : checkActiveFields) {
            
            if(oldMap.get(a.Id).Active__c != a.Active__c) {
                
                for (Flight__c b : idsDb) {
                    
                    if(!b.Tourist__r.Active__c) {
                        b.SecondStatus__c = 'Declined';
                        modifiedSecondStatus.add(b);
                    }
                }
            }
        }
        update modifiedSecondStatus;
    }
}
