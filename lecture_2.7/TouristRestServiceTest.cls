@IsTest
private class TouristRestServiceTest {
    private static List<Tourist__c> tourists;
    
    static {
        tourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetTouristsByName() {
        String touristName = tourists[0].Name;
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();      
        RestContext.request.addParameter('fuzzyname', touristName);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    private static void testGetTourists() {
        List<Tourist__c> touristsFromDB = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c
        ];
        
        String touristName = tourists[0].Name;
        String touristAge = String.valueOf(touristsFromDB[0].Age__c); 
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();          
        RestContext.request.addParameter('fuzzyname', touristName);
        RestContext.request.addParameter('age', touristAge);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
        System.assertEquals(3, RestContext.response.responseBody.size());
    }
    
    @IsTest
    private static void testGetTouristsErrorValidationName() {
        List<Tourist__c> touristsFromDB = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c
        ];
        String touristAge = String.valueOf(touristsFromDB[0].Age__c); 
        
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
        List<Tourist__c> touristsFromDB = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c
        ];
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
        
        List<Tourist__c> touristsFromDb = [
            SELECT Name, 
            Email__c 
            FROM Tourist__c
        ];
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_201, RestContext.response.statusCode); 
        System.assertEquals(4, touristsFromDb.size());
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
        
        List<Tourist__c> touristsFromDb = [
            SELECT Name, 
            Email__c 
            FROM Tourist__c
        ];
                
        System.assertEquals(Constants.RESPONSE_BODY_DUPLICATE_RECORD, RestContext.response.responseBody.toString());
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_409, RestContext.response.statusCode);
        System.assertEquals(3, touristsFromDb.size());  
    }
}