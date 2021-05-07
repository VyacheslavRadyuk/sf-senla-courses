public class WeatherDailyForecastManager {
	
    public static List<Weather_Daily_Forecast__c> getByNotEmptySpacePoint() {
        List<Weather_Daily_Forecast__c> weatherList = [
            SELECT Space_Point__r.Id 
            FROM Weather_Daily_Forecast__c 
            WHERE Space_Point__r.Id != NULL];
        return weatherList;
    }
}