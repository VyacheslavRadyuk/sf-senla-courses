public class WeatherForecastUpdater {
    
    @future(callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> listSpacePoint = SpacePointManager.getSpacePoints();
        List<Weather_Daily_Forecast__c> dailyForecasts = new List<Weather_Daily_Forecast__c>();
        
        for (Space_Point__c spacePoint : listSpacePoint) {
            Map<Date, Decimal> forecastByCoordinates = WeatherForecastService.getForecasts(spacePoint.Latitude__c, spacePoint.Longitude__c);
            
            for (Date mapId : forecastByCoordinates.keyset()) {
                Weather_Daily_Forecast__c dailyForecast = new Weather_Daily_Forecast__c();
                dailyForecast.Date__c = Date.valueOf(mapId);
                dailyForecast.Average_Temperature__c = forecastByCoordinates.get(mapId);
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