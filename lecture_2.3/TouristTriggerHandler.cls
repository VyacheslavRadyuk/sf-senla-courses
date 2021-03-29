public class TouristTriggerHandler {
    
    public static void onBeforeInsert(List<Tourist__c> newTourists) {
        TouristService.markDuplicates(newTourists);
    }
    
    public static void afterUpdate (List<Tourist__c> checkActiveFields) {
        List<String> ids = new List<String>();
        
        for (Tourist__c a : checkActiveFields) {
            ids.add(a.Id);
        }
        List<Flight__c> idsDb = FlightManager.getByTouristsId(ids);
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