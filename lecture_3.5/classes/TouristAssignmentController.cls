public without sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> getTrips(Id selectedTourist) { 
        Integer count;     
        Tourist__c tourist = TouristManager.getBySelectedId(selectedTourist)[0];      
        List<Trip__c> trips = TripManager.getTripsByTourist(tourist);
        return trips;
    }
    
    @AuraEnabled   
    public static Flight__c createFlightForTouristAssignment(Trip__c selectedTrip, Id selectedTourist) { 
        Datetime now = system.now();
        Flight__c flight = new Flight__c(
            Name = String.valueOf(now),
            Tourist__c = selectedTourist,
            Status__c = 'Requested',
            Trip__c = selectedTrip.Id
        );         
        insert flight;
        return flight;
    }
    
    @AuraEnabled(cacheable=true)   
    public static Weather_Daily_Forecast__c getWeatherForecastBySpacePoint(Trip__c selectedTrip) {
        Weather_Daily_Forecast__c weatherForecast = WeatherDailyForecastManager.getBySelectedTrip(selectedTrip)[0];
        return weatherForecast;
    }
}