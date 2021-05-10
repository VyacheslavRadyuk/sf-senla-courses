@IsTest
private class TouristRestServiceTest {
    private static List<Tourist__c> touristsToInsert;
    
    static {
        touristsToInsert = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetTouristsByName() {
        String touristName = touristsToInsert[0].Name;
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        
        RestContext.request.requestURI = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;   
        RestContext.request.addParameter('fuzzyname', touristName);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTourists() {
        List<Tourist__c> touristsFromDB = [
            SELECT Name, 
            Age__c 
            FROM Tourist__c
        ];
        
        String touristName = touristsToInsert[0].Name;
        String touristAge = String.valueOf(touristsFromDB[0].Age__c);
        
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        
        RestContext.request.requestURI = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;   
        RestContext.request.addParameter('fuzzyname', touristName);
        RestContext.request.addParameter('age', touristAge);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_200, RestContext.response.statusCode);
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
        
        RestContext.request.requestURI = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;   
        RestContext.request.addParameter('age', touristAge);
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testGetTouristsErrorValidationTypeAge() {       
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        
        RestContext.request.requestURI = '/services/apexrest/Tourist';
        RestContext.request.httpMethod = Constants.HTTP_METHOD_GET;   
        RestContext.request.addParameter('age', 'abc');
               
        Test.startTest();
        	TouristRestService.getTourists();
        Test.stopTest();
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_404, RestContext.response.statusCode);
    }
    
    @IsTest
    private static void testCreateTourist() {       
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = 'POST';
         
        String name = 'Viktor';
        String birthday = '2000-03-03';
        String email = 'vyacheslavradyuk@gmail.com';
        
        Test.startTest();
        	TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        List<Tourist__c> tourists = [
            SELECT Name, 
            Email__c 
            FROM Tourist__c 
            WHERE Name = :name  AND Email__c = :email
        ];
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_201, RestContext.response.statusCode);  
    }
    
     @IsTest
    private static void testCreateTouristErrors() {       
        RestContext.request = new RestRequest();
        RestContext.response = new RestResponse();
        RestContext.request.requestURI = '/services/apexrest/Tourist/';
        RestContext.request.httpMethod = 'POST';
         
        String name = 'Sasha';
        String birthday = '2000-03-03';
        String email = 'vyacheslavradyuk@gmail.com';
        
        Test.startTest();
        	TouristRestService.createTourist(name, birthday, email);
        Test.stopTest();
        
        List<Tourist__c> tourists = [
            SELECT Name, 
            Email__c 
            FROM Tourist__c 
            WHERE Name = :name AND Email__c = :email
        ];
        
        System.assertEquals(Constants.RESPONSE_STATUS_CODE_409, RestContext.response.statusCode);
    }
}