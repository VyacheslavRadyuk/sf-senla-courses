public class TouristTriggerHandler {
    
    public static void onAfterInsert(Set<Id> touristIds) {
        TouristServiceFuture.markDuplicates(touristIds);
    }
    
    public static void afterUpdate (Map<Id, Tourist__c> oldMap, List<Tourist__c> checkActiveFields) {     
        Set<Id> ids = new Set<Id>();
        
        for (Tourist__c activeField : checkActiveFields) {
            ids.add(activeField.Id);
        }
        List<Flight__c> idsDb = FlightManager.getByTouristsId(ids);             
        if (idsDb == null || idsDb.isEmpty()) return;
        
        List<flight__c> modifiedSecondStatus = new List<flight__c>();
        
        for (Tourist__c activeField : checkActiveFields) {          
            if(oldMap.get(activeField.Id).Active__c != activeField.Active__c) {
                
                for (Flight__c idDb : idsDb) {                  
                    if(!idDb.Tourist__r.Active__c) {
                        idDb.SecondStatus__c = constants.FLIGHT_STATUS_DECLINED;
                        modifiedSecondStatus.add(idDb);
                    }
                }
            }
        }
        update modifiedSecondStatus;
    }
}