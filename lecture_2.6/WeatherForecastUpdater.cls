public class WeatherForecastUpdater {
    
    @future(callout = true)
    public static void updateForecasts() {
        List<Space_Point__c> listSpacePoint = SpacePointManager.getSpacePoints();
        List<Weather_Daily_Forecast__c> dailyForecasts = new List<Weather_Daily_Forecast__c>();
        
        for (Space_Point__c spacePoint : listSpacePoint) {
            try{
                Map<Date, Decimal> forecastByCoordinates = WeatherForecastService.getForecasts(spacePoint.Latitude__c, spacePoint.Longitude__c);
                
                for (Date forecast : forecastByCoordinates.keyset()) {
                    Weather_Daily_Forecast__c dailyForecast = new Weather_Daily_Forecast__c();
                    dailyForecast.Date__c = Date.valueOf(forecast);
                    dailyForecast.Average_Temperature__c = forecastByCoordinates.get(forecast);
                    dailyForecast.Space_Point__c = spacePoint.Id;
                    dailyForecast.Name = spacePoint.City__c;
                    dailyForecasts.add(dailyForecast);
                }      
            } catch (WeatherForecastService.WeatherForecastException ex) {
                System.debug(LoggingLevel.ERROR, ex.getMessage());  
            }
        }
        List<Weather_Daily_Forecast__c> oldDailyForecasts = WeatherDailyForecastManager.getByNotEmptySpacePoint();
        delete oldDailyForecasts;
        insert dailyForecasts;
    }
}