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
}