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
        System.debug(listTourists);
        return listTourists;   
    }
     
    public static List<Tourist__c> getByAge(Set<Integer> ages){         
        if (Ages.contains(null)) {
	    return new List<Tourist__c>();   
        }
        List<Tourist__c> listTourists = [							
            SELECT Age__c, 
            Name 
            FROM Tourist__c 
            WHERE Age__c IN :ages
        ];
        system.debug(listTourists);
        return listTourists;
    }
    
    public static List<Tourist__c> getByFlightsCount(Integer count){
        List<Tourist__c > listTourists = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c 
            WHERE Upcoming_Flights_Count__c = :count
        ];
        System.debug(listTourists);
        return (listTourists);
        
    }
    
    public static List<Tourist__c> getTourists() {
        List<Tourist__c> newTourists = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
        ];
        System.debug(newTourists);
        return (newTourists);
        
    }
    
    public static List<Tourist__c> getFreeTourists() {
    List<Tourist__c> freeTourist = [
            SELECT Id,
        	Age__c
            FROM Tourist__c
            WHERE Upcoming_Flights_Count__c = 0
        ];
        System.debug(freeTourist);
        return freeTourist;
    }
}