public without sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> getTrips(Id selectedTourist) {
        if(selectedTourist == null || String.isBlank(selectedTourist) ) {
            throw new AuraHandledException(Constants.ASSIGN_SCREEN_ERROR_MSG_NO_TOURISTS_SELECTED);
        }
    
        Tourist__c tourist = TouristManager.getBySelectedId(selectedTourist)[0];      
        List<Trip__c> trips = TripManager.getTripsByTourist(tourist);
        List<Flight__c> flightsByTouristId = FlightManager.getByTouristId(tourist.Id);
        
        try{
            if (flightsByTouristId.size() > 0) {    
                for (Integer i = 0; i < trips.size(); i++) {
                    
                    for (Flight__c flight : flightsByTouristId) {
                        if(flight.Trip__r.Start_Date__c <= trips[i].End_Date__c && trips[i].Start_Date__c <= flight.Trip__r.End_Date__c) {
                            trips.remove(i);     
                        }
                    }
                }
            }
        } catch (Exception ex) {
            throw new AuraHandledException(Constants.UNEXPECTED_ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        return trips;
    }
    
    @AuraEnabled   
    public static Flight__c createFlightForTouristAssignment(Trip__c selectedTrip, Id selectedTourist) { 
        if(selectedTrip == null) {
            throw new AuraHandledException(Constants.ASSIGN_SCREEN_ERROR_MSG_NO_TRIPS_SELECTED);
        }
        
        Flight__c flightToInsert = new Flight__c();
        
        try{
            Datetime now = system.now();
            Flight__c flight = new Flight__c(
                Name = String.valueOf(now),
                Tourist__c = selectedTourist,
                Status__c = 'Requested',
                Trip__c = selectedTrip.Id
            );
            flightToInsert = flight;
        } catch(Exception ex) {
            throw new AuraHandledException(Constants.UNEXPECTED_ERROR_CONTACT_SYSTEM_ADMINISTRATOR);
        }
        
        insert flightToInsert;
        return flightToInsert;
    }
    
    @AuraEnabled(cacheable=true)   
    public static Weather_Daily_Forecast__c getWeatherForecastBySpacePoint(Trip__c selectedTrip) {
        Weather_Daily_Forecast__c weatherForecast = WeatherDailyForecastManager.getBySelectedTrip(selectedTrip)[0];
        return weatherForecast;
    }
}