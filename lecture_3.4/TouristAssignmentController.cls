public inherited sharing class TouristAssignmentController {
    
	@AuraEnabled(cacheable=true) 
    public static List<Tourist__c> getTourists() {
        List<Tourist__c> tourists = [
            SELECT Id, 
            Name, 
            Email__c, 
            Gender__c,
            Age__c,
            Active__c
            FROM Tourist__c
            WHERE Active__c = true
        ];
        return tourists;
    }
    
    @AuraEnabled(cacheable=true) 
    public static List<Trip__c> getTrips(Tourist__c selectedTourist) { 
        Integer count;
        
        List<Trip__c> trips = [
            SELECT Id, 
            Name, 
            Start_Date__c,
            End_Date__c,
            Seats__c,
            Departure_Space_Point__c,
            Departure_Space_Point__r.Latitude__c,
            Departure_Space_Point__r.Longitude__c,
            Minimum_Age__c    
            FROM Trip__c
            WHERE Minimum_Age__c <= :selectedTourist.Age__c
            AND Start_Date__c >= :Date.today()
        ];
        
        List<Flight__c> flights = [
            SELECT Trip__c, Trip__r.Id, Trip__r.Start_Date__c, Trip__r.End_Date__c FROM Flight__c  
        ];
        
        for (Integer i = 0; i < trips.size(); i++) {
            count = 0;
            
            for (Flight__c flight : flights) {
                if (flight.Trip__r.Id == trips[i].Id) {
                    count++;
                    
                    if (count == trips[i].Seats__c) {
                        trips.remove(i);
                        break;
                    }  
                } 
            } 
        }  
        return trips;
    }
    
    @AuraEnabled   
    public static Flight__c createFlightForTouristAssignment(trip__c selectedTrip, Tourist__c selectedTourist) { 
        Integer randomNumber;
        randomNumber = Integer.valueof((Math.random() * 1000000));
        Flight__c flight = new Flight__c(
            Name = String.valueOf(randomNumber),
            Tourist__c = selectedTourist.Id,
            Status__c = 'Requested',
            Trip__c = selectedTrip.Id
        );         
        insert flight;
        return flight;
    }
    
    @AuraEnabled(cacheable=true)   
    public static Weather_Daily_Forecast__c getWeatherForecastBySpacePoint(trip__c selectedTrip) {
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
    
    @AuraEnabled(cacheable=true) 
    public static List<Flight__c> getFlightsBySelectedTrip(Trip__c selectedTrip) {
        List<Flight__c> flights = [
            SELECT Trip__c,
            Trip__r.Id
            FROM Flight__c
            WHERE Trip__r.Id = :selectedTrip.Id
        ];
        return flights;
    }
}