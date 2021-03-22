public class TouristTriggerHandler {
    public static void afterUpdate (List<Tourist__c> checkActiveFields) {
        List<flight__c> ids = new List<flight__c>();
        
        for (Tourist__c a : checkActiveFields) {
            flight__c status = [
                SELECT Tourist__r.id,  
                Tourist__r.Active__c, 
                SecondStatus__c
                FROM flight__c
                WHERE Tourist__r.id = :a.Id
            ];
            
            if(!status.Tourist__r.Active__c) {
                status.SecondStatus__c = 'Declined';
                ids.add(status);
            }
        }
        update ids;
    }
}