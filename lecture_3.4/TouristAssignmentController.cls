public inherited sharing class TouristAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Trip__c> getTrips(Id selectedTourist) { 
        Integer count;
        
        Tourist__c tourist = [
            SELECT Id, Age__c FROM Tourist__c WHERE Id = :selectedTourist
        ];
        
        List<Trip__c> trips = [
            SELECT Id, 
            Name, 
            Start_Date__c,
            End_Date__c,
            Seats__c,
            countOccupiedSeats__c,
            Departure_Space_Point__c,
            Departure_Space_Point__r.Latitude__c,
            Departure_Space_Point__r.Longitude__c,
            Minimum_Age__c    
            FROM Trip__c
            WHERE Minimum_Age__c <= :tourist.Age__c
            AND Start_Date__c >= :Date.today()
        ];     
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
        Weather_Daily_Forecast__c weatherForecast = [
            SELECT Id,
            Date__c,
            Average_Temperature__c,
            Space_Point__c
			FROM Weather_Daily_Forecast__c
            WHERE Space_Point__r.Id = :selectedTrip.Departure_Space_Point__r.Id
            LIMIT 1
        ]; 
        return weatherForecast;
    }
}