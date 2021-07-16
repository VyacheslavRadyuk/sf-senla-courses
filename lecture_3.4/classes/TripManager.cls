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
    
    public static List<Trip__c> getTripsByTourist(Tourist__c tourist) { 
        if (tourist == null) {
            return new List<Trip__c>();
        }
        List<Trip__c> trips = [
            SELECT Id, 
            Name, 
            Start_Date__c,
            End_Date__c,
            Seats__c,
            countOccupiedSeats__c,
            Departure_Space_Point__c,
            Departure_Space_Point__r.Latitude__c,
            Departure_Space_Point__r.Longitude__c,
            Minimum_Age__c    
            FROM Trip__c
            WHERE Minimum_Age__c <= :tourist.Age__c
            AND Start_Date__c >= :Date.today()
            AND Id NOT IN (SELECT Trip__c 
                FROM Flight__c 
                WHERE Tourist__c = :tourist.Id)
        ];     
        return trips;
    }
}