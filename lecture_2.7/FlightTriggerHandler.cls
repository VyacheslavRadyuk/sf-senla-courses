public class FlightTriggerHandler {
    public static void beforeInsert (List<Flight__c> newFlights) { 
        if (newFlights == null || newFlights.isEmpty()) return;
        Set<Id> touristId = new Set<Id>();
        Set<Id> tripId = new Set<Id>();
        
        for(Flight__c a : newFlights) {
            touristId.add(a.Tourist__c);
            tripId.add(a.Trip__c);
        }
        List<Trip__c> tripDb = TripManager.getById(tripId);
        Map<Id,Trip__c> tripMap = new Map<Id,Trip__c> (tripDb);
        
        List<Tourist__c> touristDb = TouristManager.getById(touristId);
        Map<Id,Tourist__c> touristMap = new Map<Id,Tourist__c> (touristDb);
        
        for(Flight__c a : newFlights) {
            Tourist__c tourist = touristMap.get(a.Tourist__c);
            Trip__c trip = tripMap.get(a.Trip__c);
            
            if(trip.Start_Date__c < date.today()) {
                a.Trip__c.addError(Constants.TRIP_PLANE_FLEW_AWAY_ERROR); 
            }       
            
            if(tourist.Age__c < trip.Minimum_Age__c) {
                a.Tourist__c.addError(Constants.TRIP_INSUFFICIENT_AGE_ERROR);
            }
        }     
    }
}