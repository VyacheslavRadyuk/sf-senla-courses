public class WeatherDailyForecastManager {
    
    public static List<Weather_Daily_Forecast__c> getByNotEmptySpacePoint() {
        List<Weather_Daily_Forecast__c> weatherList = [
            SELECT Space_Point__r.Id 
            FROM Weather_Daily_Forecast__c 
            WHERE Space_Point__r.Id != NULL];
        return weatherList;
    }
    
    public static List<Weather_Daily_Forecast__c> getBySelectedTrip(Trip__c selectedTrip) {
        if (selectedTrip == null) {
            return new List<Weather_Daily_Forecast__c>();
        }
        List<Weather_Daily_Forecast__c> weatherForecast = [
            SELECT Id,
            Date__c,
            Average_Temperature__c,
            Space_Point__c
            FROM Weather_Daily_Forecast__c
            WHERE Space_Point__r.Id = :selectedTrip.Departure_Space_Point__r.Id
        ]; 
        return weatherForecast;
    }
}