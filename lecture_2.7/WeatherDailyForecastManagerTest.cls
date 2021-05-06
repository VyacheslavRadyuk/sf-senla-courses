@isTest
private class WeatherDailyForecastManagerTest {
    
    @IsTest
    static void testGetByNotEmptySpacePoint() {
        List<Weather_Daily_Forecast__c> forecastsToInsert = TestDataFactory.createForecasts();
        List<Weather_Daily_Forecast__c> forecastsDb = WeatherDailyForecastManager.getByNotEmptySpacePoint();
        system.debug(forecastsDb);
        System.assertEquals(1, forecastsDb.size());
        System.assertEquals(forecastsToInsert.get(1).Space_Point__c, forecastsDb.get(0).Space_Point__c);
    }
}