public class DataTableAuraServices {
    
    @AuraEnabled  
    public static List<Tourist__c> fetchTourist(Id tripRecordId) {
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
        Integer randomNumber;
        List<Flight__c> flights = new List<Flight__c>();
        
        for (Tourist__c tourist : selectedTourists) {
            randomNumber = Integer.valueof((Math.random() * 1000000));
            Flight__c flight = new Flight__c(
                Name = String.valueOf(randomNumber),
                Tourist__c = tourist.Id,
                SecondStatus__c = constants.FLIGHT_SECOND_STATUS_OFFER_PENDING,
                Trip__c = tripRecordId
            );
            flights.add(flight);          
        }
        insert flights;
        return flights;
    }
    
    @AuraEnabled  
    public static Integer getFlightsByTripId(Id tripRecordId) {
        List<Flight__c> flights = FlightManager.getByRecordId(tripRecordId);
        Integer flightsCount = flights.size(); 
        return flightsCount;
    }
    
    @AuraEnabled  
    public static Integer getSeatsByTripId(Id tripRecordId) {
        Integer countSeats = Integer.valueOf(TripManager.getByRecordId(tripRecordId)[0].Seats__c);
        return countSeats;
    }
    
    @AuraEnabled 
    public static Date getStartDate(Id tripRecordId) {
        Trip__c trip = TripManager.getByRecordId(tripRecordId)[0];
        Date StartDate = Date.valueOf(trip.Start_Date__c);   
        return StartDate;
    }
}