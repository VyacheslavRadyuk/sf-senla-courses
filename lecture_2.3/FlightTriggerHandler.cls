public class FlightTriggerHandler {
    public static void beforeInsert (List<Flight__c> newFlights) { 
        List<String> touristId = new List<String>();
        List<String> tripId = new List<String>();
        
        for(Flight__c a : newFlights) {
            touristId.add(a.Tourist__c);
            tripId.add(a.Trip__c);
        }
        List<Trip__c> tripDb = TripManager.getById(tripId);
        List<Tourist__c> touristDb = TouristManager.getById(touristId);
        
        for(Flight__c a : newFlights) {
            
            if(a.Trip__r.Start_Date__c < date.today()) {
                a.Trip__c.addError('The plane flew away'); 
            }
            
            if(a.Tourist__r.Age__c < a.Trip__r.Minimum_Age__c) {
                a.Tourist__c.addError('Insufficient age');
            }
        }
    }
}