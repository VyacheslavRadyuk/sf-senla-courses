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
    
     public static List<Trip__c> getByRecordId(Id tripRecordId) { 
        if (tripRecordId == null || String.isBlank(tripRecordId)) {
            return new List<Trip__c>();
        }
        List<Trip__c> status = [
            SELECT Id,
            Minimum_Age__c,
            Start_Date__c,
            End_Date__c,
            Seats__c
            FROM Trip__c
            WHERE Id = :tripRecordId         
        ];
        return status;
    }
}