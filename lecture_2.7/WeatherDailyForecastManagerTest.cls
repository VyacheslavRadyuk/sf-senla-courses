@IsTest
private class WeatherDailyForecastManagerTest {
    
    @IsTest
     private static void testGetByNotEmptySpacePoint() {
        List<Weather_Daily_Forecast__c> forecasts = TestDataFactory.createForecasts();
        List<Weather_Daily_Forecast__c> forecastsDb = WeatherDailyForecastManager.getByNotEmptySpacePoint();
         
        System.assertNotEquals(null, forecastsDb);
        System.assertEquals(1, forecastsDb.size());
        System.assertNotEquals(null, forecastsDb.get(0).Space_Point__c);
    }
}