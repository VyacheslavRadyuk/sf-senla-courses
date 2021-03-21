public class TouristManager {
    
    public static List<Tourist__c> getTouristsByName(String name){
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
    
    
    /*   List<Integer> ages = new List<Integer>();
			ages.add(20);
			ages.add(22);
			ages.add(24);
			TouristManager.getTouristsByAge(ages);
	*/
    
    public static List<Tourist__c> getTouristsByAge(Set<Integer> ages){         
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
    
    public static List<Flight__c> getFlightsByYear(Integer year){
        if(year == null || year == 0) {
            return new List<Flight__c>();
        }
        List<Flight__c> listFlights = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c 
            FROM Flight__c 
            WHERE CALENDAR_YEAR(Trip__r.Start_Date__c)>= :year
        ];
        System.debug(listFlights);
        return listFlights;
        
    }
    
    public static List<Flight__c> getFlights(){
        List<Flight__c> listFlights = [
            SELECT Tourist__r.Name, 
            Tourist__r.Age__c, 
            Trip__r.Name, 
            Trip__r.Start_Date__c 
            FROM Flight__c
        ];
        System.debug(listFlights);
        return listFlights;
        
    }
    
    public static List<Tourist__c > getTouristsByFlightsCount(Integer count){
        List<Tourist__c > listTourists = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c 
            WHERE Upcoming_Flights_Count__c = :count
        ];
        System.debug(listTourists);
        return (listTourists);
        
    }
    
    public static List<Tourist__c> getByNameEmailIsDuplicate() {
        List<Tourist__c> newTourists = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
        ];
        System.debug(newTourists);
        return (newTourists);
        
    }
}