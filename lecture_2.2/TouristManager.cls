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
    
    public static List<Tourist__c> getTourists(List<String> name, List<String> email) {
        
        if (name == null || name.isEmpty() || email == null || email.isEmpty()) {
            return new List<Tourist__c>();
        }
        List<Tourist__c> allTourists = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
            WHERE Name IN :name AND Email__c IN :email AND IsDuplicate__c = false
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
}