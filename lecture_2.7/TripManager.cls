public class TripManager {
    
    public static List<Trip__c> getById(Set<Id> tripId) { 
        if (tripId == null || tripId.isEmpty()) {
            return new List<Trip__c>();
        }
        List<Trip__c> status = [
            SELECT Minimum_Age__c,
            Start_Date__c,
            Name
            FROM Trip__c
            WHERE Id IN :tripId         
        ];
        return status;
    }
}