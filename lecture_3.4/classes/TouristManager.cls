public class TouristManager {
       
    public static List<Tourist__c> getByName(String name){
        if(String.isBlank(name)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> listTourists = [
            SELECT Age__c, 
            Name 
            FROM Tourist__c 
            WHERE Name = :name
        ]; 
        return listTourists;   
    }
    
    public static List<Tourist__c> getByAge(Set<Integer> ages){  
        if (ages == null || ages.isEmpty()) {
            return new List<Tourist__c>();   
        }
        List<Tourist__c> listTourists = [							
            SELECT Age__c, 
            Name 
            FROM Tourist__c 
            WHERE Age__c IN :ages
        ];
        return listTourists;
    }
    
    public static List<Tourist__c> getByFlightsCount(Integer count){
        List<Tourist__c > listTourists = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c 
            WHERE Upcoming_Flights_Count__c = :count
        ];
        return (listTourists);        
    }
    
    public static List<Tourist__c> getTourists(List<String> name, List<String> email, Set<Id> newIds) {  
        if (name == null || name.isEmpty() || email == null || email.isEmpty() || newIds == null || newIds.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> allTourists = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
            WHERE Name IN :name AND Email__c IN :email AND IsDuplicate__c = false AND Id NOT IN :newIds
        ];
        return (allTourists);  
    }
       
    public static List<Tourist__c> getFreeTourists() {
        List<Tourist__c> freeTourist = [
            SELECT Id,
            Age__c
            FROM Tourist__c
            WHERE Upcoming_Flights_Count__c = 0
        ];
        return freeTourist;
    }
    
    public static List<Tourist__c> getById(Set<Id> touristId) {  
        if (touristId == null || touristId.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> status = [
            SELECT Age__c,
            Name, 
            Email__c 
            FROM Tourist__c
            WHERE Id IN :touristId     
        ];
        return status;
    }
    
    public static List<Tourist__c> getByParams(String name, Integer age) {
        if (String.isBlank(name) || age == null) {
            return new List<Tourist__c>();
        }
        List<List<Tourist__c>> touristList = [
            FIND :name IN Name FIELDS RETURNING Tourist__c(Id, Name, Age__c WHERE Age__c = :age)
        ];
        return touristList[0];
    }
    
    public static List<Tourist__c> getByNameSosl(String name) {
        if (String.isBlank(name)) {
            return new List<Tourist__c>();
        }
        List<List<Tourist__c>> touristList = [
            FIND :name IN Name FIELDS RETURNING Tourist__c(Id, Name, Age__c)
        ];
        return touristList[0];
    }
    
    public static List<Tourist__c> getByResponseBody(String name, String email){
        if(String.isBlank(name) || String.isBlank(email)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> touristsList = [
            SELECT Name, 
            Birthdate__c, 
            Email__c 
            FROM Tourist__c
            WHERE Name = :name AND Email__c = :email
        ];
        return touristsList;
    }
    
    public static List<Tourist__c> getNotRelatedTourists(String tripId) {
        if (String.isBlank(tripId)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> touristsList = [
            SELECT Name,
            Age__c,
            Upcoming_Flights_Count__c
            FROM Tourist__c
            WHERE Id NOT IN
            (SELECT Tourist__c FROM Flight__c WHERE Trip__c = :tripId)
            ORDER BY Upcoming_Flights_Count__c
            LIMIT 10
        ];
        return touristsList;
    }
    
    public static List<Tourist__c> getFreeTouristsForTheFlight(Trip__c trip, Set<Id> touristId) { 
        if (trip == null) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> status = [
            SELECT Name,
            Age__c,
            Email__c,
            Gender__c
            FROM Tourist__c
            WHERE Age__c >= :trip.Minimum_Age__c
            AND Active__c = true
            AND Id NOT IN :touristId     
        ];
        return status;
    }
    
    public static List<Tourist__c> getBySelectedId(Id touristId) {  
        if (touristId == null || String.isBlank(touristId)) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> tourist = [
            SELECT Age__c,
            Name, 
            Email__c 
            FROM Tourist__c
            WHERE Id = :touristId
        ];
        return tourist;
    }   
}