public class WeatherForecastUpdater {
    
    @future(callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> listSpacePoint = SpacePointManager.getSpacePoints();
        List<Weather_Daily_Forecast__c> dailyForecasts = new List<Weather_Daily_Forecast__c>();
        
        for (Space_Point__c spacePoint : listSpacePoint) {
            Map<Date, Decimal> myMap = WeatherForecastService.getForecasts(spacePoint.Latitude__c, spacePoint.Longitude__c);
            
            for (Date a : myMap.keyset()) {
                Weather_Daily_Forecast__c dailyForecast = new Weather_Daily_Forecast__c();
                dailyForecast.Date__c = date.valueOf(a);
                dailyForecast.Average_Temperature__c = myMap.get(a);
                dailyForecast.Space_Point__c = spacePoint.Id;
                dailyForecast.Name = spacePoint.City__c;
                dailyForecasts.add(dailyForecast);
            }      
        }
        List<Weather_Daily_Forecast__c> weatherList = WeatherDailyForecastManager.getByNotEmptySpacePoint();
        delete weatherList;
        insert dailyForecasts;
    }
}