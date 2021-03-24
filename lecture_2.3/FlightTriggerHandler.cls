public class FlightTriggerHandler {
    public static void beforeInsert (List<Flight__c> newFlights) { 
        List<String> touristId = new List<String>();
        List<String> tripId = new List<String>();
        
        for (Flight__c a : newFlights) {
            touristId.add(a.Tourist__c);
            tripId.add(a.Trip__c);
        }
        List<Flight__c> flightsDb = FlightManager.getBytouristIdTripId(touristId, tripId);
        
        for (Flight__c a : newFlights) {
            
            for(Flight__c b : flightsDb) {
                
                if (b.Tourist__r.Age__c < b.trip__r.Minimum_Age__c) {
                    a.Tourist__c.addError('Insufficient age');
                }
                
                if (b.trip__r.Start_Date__c < date.today()) {
                    a.Trip__c.addError('The plane flew away');
                }
            }
        }
    }
}
