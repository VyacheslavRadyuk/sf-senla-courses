public inherited sharing class RegistrationOfTripsController {
    
    @AuraEnabled(cacheable=true) 
    public static List<Tourist__c> fetchTourists(Id tripRecordId) {
        Trip__c trip = TripManager.getByRecordId(tripRecordId)[0];
        List<Flight__c> flights = FlightManager.getByRecordId(tripRecordId);  
        Set<Id> touristId = new Set<Id>();
        
        for (Flight__c flight : flights) {
            if(flight.Trip__r.Start_Date__c <= trip.End_Date__c && trip.Start_Date__c <= flight.Trip__r.End_Date__c) {
                touristId.add(flight.Tourist__c);
            }
        }    
        List<Tourist__c> tourists = TouristManager.getFreeTouristsForTheFlight(trip, touristId);        
        return tourists;   
    }
    
    @AuraEnabled  
    public static List<Flight__c> createFlights(Id tripRecordId, List<Tourist__c> selectedTourists) { 
        Datetime now = system.now();
        List<Flight__c> flights = new List<Flight__c>();
        
        for (Tourist__c tourist : selectedTourists) {
            Flight__c flight = new Flight__c(
                Name = String.valueOf(now),
                Tourist__c = tourist.Id,
                SecondStatus__c = constants.FLIGHT_SECOND_STATUS_OFFER_PENDING,
                Trip__c = tripRecordId
            );
            flights.add(flight);          
        }
        insert flights;
        return flights;
    }   
}