public class TestDataFactory {
    
    public static List<Space_Point__c> createSpacePoints() {
        List<Space_Point__c> spacePointsToInsert = new List<Space_Point__c>{
            new Space_Point__c(Name = 'Grodnia'),
            new Space_Point__c(Name = 'Borisov')   
        };
        insert spacePointsToInsert;
        return spacePointsToInsert;
    }
    
    public static List<Weather_Daily_Forecast__c> createForecasts() {
        List<Weather_Daily_Forecast__c> forecastsToInsert = new List<Weather_Daily_Forecast__c>{
            new Weather_Daily_Forecast__c(Name = 'test1'),
            new Weather_Daily_Forecast__c(Name = 'test2', Space_Point__c = createSpacePoints().get(0).Id)     
        };   
        insert forecastsToInsert;
        return forecastsToInsert;
    }
    
    public static List<Trip__c> createTrips() {
        List<Trip__c> tripsToInsert = new List<Trip__c> {
            new Trip__c(Name = 'Minsk', Start_Date__c = date.newInstance(2021,07,07)),
            new Trip__c(Name = 'Moskow',Start_Date__c = date.newInstance(2021,07,07))    
        };
        insert tripsToInsert;
        return tripsToInsert;
    }
    
    public static List<Tourist__c> createTourists() {
        List<Tourist__c> touristToInsert = new List<Tourist__c> {
            new Tourist__c(Name = 'Slava', Birthdate__c = date.newInstance(2000,03,03), Email__c = 'vyacheslavradyuk@gmail.com', IsDuplicate__c = false),
            new Tourist__c(Name = 'Sasha', Birthdate__c = date.newInstance(2000,03,03), Email__c = 'vyacheslavradyuk@gmail.com', IsDuplicate__c = false)    
        };
        insert touristToInsert;
        return touristToInsert;
    }
         
    public static List<Flight__c> createFlights() {
        List<Trip__c> tripsToInsert = createTrips();
        List<Tourist__c> touristToInsert = createTourists();
        List<Flight__c> flightsToInsert = new List<Flight__c> {
            new Flight__c(Name = '777', Tourist__c = touristToInsert.get(0).Id, Trip__c = tripsToInsert.get(0).Id),
            new Flight__c(Name = '888', Tourist__c = touristToInsert.get(0).Id, Trip__c = tripsToInsert.get(0).Id)   
        };
        insert flightsToInsert;
        return flightsToInsert;
    }  
}