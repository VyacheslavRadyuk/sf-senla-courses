@IsTest
private class WeatherForecastUpdaterTest {
    private static List<Space_Point__c> spacePointsToInsert;
    
    static {
        spacePointsToInsert = TestDataFactory.createSpacePoints();
    }
      
    @IsTest
    private static void testGetForecasts() {        
        Test.setMock(HttpCalloutMock.class, new WeatherForecastHttpCalloutMock());
        WeatherForecastHttpCalloutMock.successIndicator = 'success';
        
        Test.startTest();
        	Map<Date, Decimal> dataMap = WeatherForecastService.getForecasts((Decimal)spacePointsToInsert[0].Latitude__c, (Decimal)spacePointsToInsert[0].Longitude__c);
        Test.stopTest();
        
        System.assertEquals(2.5, dataMap.get(Date.valueOf(String.valueOf('2021-05-20'))));
        System.assertEquals(1, dataMap.size());
        System.assertNotEquals(null, dataMap); 
    }
       
    @IsTest
    private static void testUpdateForecasts() {        
        Test.setMock(HttpCalloutMock.class, new WeatherForecastHttpCalloutMock());
        WeatherForecastHttpCalloutMock.successIndicator = 'success';
        
        Test.startTest();
        	WeatherForecastUpdater.updateForecasts();
        Test.stopTest();
        
        List<Weather_Daily_Forecast__c> weatherForecastsFromDb = WeatherDailyForecastManager.getByNotEmptySpacePoint();
        
        System.assertEquals(2, weatherForecastsFromDb.size());
        System.assertEquals(spacePointsToInsert[0].Id, weatherForecastsFromDb[0].Space_Point__c);
        System.assertEquals(spacePointsToInsert[1].Id, weatherForecastsFromDb[1].Space_Point__c);
    }
    
    @IsTest
    private static void testUpdateForecastsNullSpacePointParameter() {              
        Test.setMock(HttpCalloutMock.class, new WeatherForecastHttpCalloutMock());
        WeatherForecastHttpCalloutMock.successIndicator = 'noSuccess';
        
        Test.startTest();	
        	try{	
        		WeatherForecastUpdater.updateForecasts();
       		} catch (WeatherForecastService.WeatherForecastException ex) {
            	System.assertEquals(Constants.WEATHER_FORECAST_CUSTOM_EXCEPTION_ERROR, ex.getMessage());  
        	}        
        Test.stopTest(); 
        
        List<Weather_Daily_Forecast__c> weatherForecastsFromDb = WeatherDailyForecastManager.getByNotEmptySpacePoint();

        System.assertEquals(0, weatherForecastsFromDb.size());
    }
}