@IsTest
private class WeatherForecastServiceTest {
    
    @IsTest
    private static void testUpdateForecasts() {
        List<Space_Point__c> spacePointsToInsert =  TestDataFactory.createSpacePoints();
        
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
    private static void testUpdateForecastsNullParameter() {
        List<Space_Point__c> spacePointsToInsert =  TestDataFactory.createSpacePoints();        
        
        Test.setMock(HttpCalloutMock.class, new WeatherForecastHttpCalloutMock());
        WeatherForecastHttpCalloutMock.successIndicator = 'noSuccess';
        
        Test.startTest();	
        	try{	
            	Map<Date, Decimal> dataMap = WeatherForecastService.getForecasts((Decimal)spacePointsToInsert[1].Latitude__c, (Decimal)spacePointsToInsert[1].Longitude__c);
       	 	} catch (WeatherForecastService.WeatherForecastException ex) {
            	System.assertEquals(Constants.WEATHER_FORECAST_CUSTOM_EXCEPTION_ERROR, ex.getMessage());  
        	}        
        Test.stopTest();      
    }
}