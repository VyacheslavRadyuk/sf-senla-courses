@IsTest
private class TouristRestServiceTest {
    private static List<Tourist__c> tourists;
    
    static {
        tourists = TestDataFactory.createTourists();
    }
    
    private static List<Tourist__c> getTouristsFromDb() {
        List<Tourist__c> touristsFromDB = [
            SELECT Name, 
            Age__c,
            Email__c
            FROM Tourist__c
        ];
        return touristsFromDB;
    }
    
    @IsTest
    private static void testGetTouristsByName() {
        String touristName = tourists[0].Name;
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();      
        RestContext.request.addParameter('fuzzyname', touristName);
        
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        List<Tourist__c> touristsFromDbSosl = TouristManager.getByNameSosl(touristName);
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
        System.assertEquals(true, RestContext.response.responseBody.toString().contains(tourists[0].Name));
        System.assertEquals(1, touristsFromDbSosl.size());
        System.assertNotEquals(null, touristsFromDbSosl[0]);
    }
    
    @IsTest
    private static void testGetTourists() {       
        String touristName = tourists[0].Name;
        String touristAge = String.valueOf(getTouristsFromDb()[0].Age__c); 
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();          
        RestContext.request.addParameter('fuzzyname', touristName);
        RestContext.request.addParameter('age', touristAge);
        
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        Test.setFixedSearchResults(fixedSearchResults);

        Test.startTest();    
            TouristRestService.getTourists();
        Test.stopTest();
        
		List<Tourist__c> touristsFromDbSosl = TouristManager.getByParams(touristName, Integer.valueOf(getTouristsFromDb()[0].Age__c));        

        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
        System.assertEquals(true, RestContext.response.responseBody.toString().contains(tourists[0].Name));
        System.assertEquals(1, touristsFromDbSosl.size());
        System.assertNotEquals(null, touristsFromDbSosl[0]);
    }
    
    @IsTest
    private static void testGetTouristsErrorValidationName() {      
        String touristAge = String.valueOf(getTouristsFromDb()[0].Age__c); 
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();  
        RestContext.request.addParameter('age', touristAge);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_BODY_EMPTY_NAME, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testGetTouristsErrorValidationTypeAge() {
        String touristName = tourists[0].Name;
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.addParameter('fuzzyname', touristName);
        RestContext.request.addParameter('age', 'abc');
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
        System.assertEquals(Constants.RESPONSE_NOT_INTEGER_TYPE_AGE, RestContext.response.responseBody.toString());
    }
    
    @IsTest
    private static void testCreateTourist() { 
        String name = 'Viktor';
        String birthday = '2000-03-03';
        String email = 'vyacheslavradyuk@gmail.com';
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        
        Test.startTest();
        	TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();       
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_201, RestContext.response.statusCode); 
        System.assertEquals(4, getTouristsFromDb().size());
    }
    
    @IsTest
    private static void testCreateTouristErrors() { 
        String name = 'Sasha';
        String birthday = '2000-03-03';
        String email = 'vyacheslavradyuk@gmail.com';
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();

        Test.startTest();
        	TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
                
        System.assertEquals(Constants.RESPONSE_BODY_DUPLICATE_RECORD, RestContext.response.responseBody.toString());
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_409, RestContext.response.statusCode);
        System.assertEquals(3, getTouristsFromDb().size());  
    }
}