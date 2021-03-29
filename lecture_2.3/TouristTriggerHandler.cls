public class TouristTriggerHandler {
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
    
    public static void afterUpdate (List<Tourist__c> checkActiveFields) {
        Set<Id> ids = new Set<Id>();
        
        for (Tourist__c a : checkActiveFields) {
            ids.add(a.Id);
        }
        List<Flight__c> idsDb = FlightManager.getByTouristsId(ids);
        
        if (idsDb == null || idsDb.isEmpty()) return;
        List<flight__c> modifiedSecondStatus = new List<flight__c>();
        
        for (Tourist__c a : checkActiveFields) {
            
            for (Flight__c b : idsDb) {
                
                if(!b.Tourist__r.Active__c) {
                    b.SecondStatus__c = 'Declined';
                    modifiedSecondStatus.add(b);
                }
            }
        }
        update modifiedSecondStatus;
    }
}