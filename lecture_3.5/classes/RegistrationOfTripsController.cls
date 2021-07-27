public inherited sharing class RegistrationOfTripsController {
    
    @AuraEnabled(cacheable=true) 
    public static List<Tourist__c> fetchTourists(Id tripRecordId) {
        if(tripRecordId == null) {
            throw new AuraHandledException(Constants.ASSIGN_SCREEN_ERROR_MSG_MISSING_TRIP_ID);
        }
        
        Trip__c trip = TripManager.getByRecordId(tripRecordId)[0];
        List<Flight__c> flights = FlightManager.getByRecordId(tripRecordId);  
        Set<Id> touristId = new Set<Id>();
        
        try {
            for (Flight__c flight : flights) {
                if(flight.Trip__r.Start_Date__c <= trip.End_Date__c && trip.Start_Date__c <= flight.Trip__r.End_Date__c) {
                    touristId.add(flight.Tourist__c);
                }
            } 
        } catch(Exception ex) {
            throw new AuraHandledException(Constants.UNEXPECTED_ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        List<Tourist__c> tourists = TouristManager.getFreeTouristsForTheFlight(trip, touristId);        
        return tourists;   
    }
    
    @AuraEnabled  
    public static List<Flight__c> createFlights(Id tripRecordId, List<Tourist__c> selectedTourists) {
        if(selectedTourists == null || selectedTourists.isEmpty()) {
            throw new AuraHandledException(Constants.ASSIGN_SCREEN_ERROR_MSG_NO_TOURISTS_SELECTED);
        }
        
        Datetime now = system.now();
        List<Flight__c> flights = new List<Flight__c>();
        
        try {
            for (Tourist__c tourist : selectedTourists) {
                Flight__c flight = new Flight__c(
                    Name = String.valueOf(now),
                    Tourist__c = tourist.Id,
                    SecondStatus__c = constants.FLIGHT_SECOND_STATUS_OFFER_PENDING,
                    Trip__c = tripRecordId
                );
                flights.add(flight);          
            }
        } catch (Exception ex) {
            throw new AuraHandledException(Constants.UNEXPECTED_ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        insert flights;
        return flights;
    }   
}