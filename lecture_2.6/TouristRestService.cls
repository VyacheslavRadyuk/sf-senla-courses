@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String touristByAgeString = touristRequest.params.get('age');
        String touristByName = touristRequest.params.get('name');
        Integer touristByAge;
        
        if (String.isEmpty(touristByName) || String.isEmpty(touristByAgeString) || !touristByAgeString.isNumeric()) {
            if (String.isEmpty(touristByName)) {
                String errorString = Constants.RESPONSE_BODY_EMPTY_NAME;
                response.responseBody = Blob.valueOf(errorString);
                response.statusCode = 404;
            } else if (String.isEmpty(touristByAgeString)) {
                List<Tourist__c> tourists = TouristManager.getByNameSosl(touristByName);
                response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
                response.statusCode = 200;
            } else if (!touristByAgeString.isNumeric()) {
                String errorString = Constants.RESPONSE_NOT_INTEGER_TYPE_AGE; 
                response.responseBody = Blob.valueOf(errorString);
                response.statusCode = 404;
            }           
        } else {
            touristByAge = Integer.valueOf(touristByAgeString);
            List<Tourist__c> tourists = TouristManager.getByParams(touristByName, touristByAge);    
            response.statusCode = 200;
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
        }  
    } 
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        Tourist__c newTourist = new Tourist__c(
            Name = name,
            Birthdate__c = Date.valueOf(birthday),
            Email__c = email
        );
        List<Tourist__c> matchingTourists = TouristManager.getByResponseBody(name, email);
        
        if (!matchingTourists.isEmpty()) {
            String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = 409;   
        } else {
            insert newTourist;
        }    
    }    
}