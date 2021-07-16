public class FlightManager {
    
    public static List<Flight__c> getByYear(Integer year){
        
        if(year == null || year == 0) {
            return new List<Flight__c>();
        }
        List<Flight__c> listFlights = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c 
            FROM Flight__c 
            WHERE CALENDAR_YEAR(Trip__r.Start_Date__c)>= :year
        ];
        return listFlights; 
    }
    
    public static List<Flight__c> getFlights(){
        List<Flight__c> listFlights = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c, 
            Trip__r.Name, 
            Trip__r.Start_Date__c,
            SecondStatus__c
            FROM Flight__c
        ];
        return listFlights;  
    }
    
    public static List<Flight__c> getByTouristsId(Set<Id> ids) {  
        if (ids == null || ids.isEmpty()) {
            return new List<Flight__c>();
        }
        List<Flight__c> status = [
            SELECT Tourist__r.id,  
            Tourist__r.Active__c, 
            SecondStatus__c
            FROM flight__c
            WHERE Tourist__r.id IN :ids
        ];
        return status;
    }
    
    public static List<Flight__c> getByRecordId(Id recordId) { 
        if (recordId == null || String.isBlank(recordId)) {
            return new List<Flight__c>();
        }
        List<Flight__c> status = [
            SELECT Id,
            Tourist__c,
            Trip__r.Start_Date__c,
            Trip__r.End_Date__c
            FROM Flight__c
            WHERE Trip__c = :recordId        
        ];
        return status;
    }
    
    public static List<Flight__c> getByTouristId(Id touristId) { 
        if (touristId == null || String.isBlank(touristId)) {
            return new List<Flight__c>();
        }
        List<Flight__c> status = [
            SELECT Id,
            Tourist__c,
            Trip__r.Start_Date__c,
            Trip__r.End_Date__c
            FROM Flight__c
            WHERE Tourist__c = :touristId        
        ];
        return status;
    }
}