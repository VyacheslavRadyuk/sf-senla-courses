@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String touristAgeString = touristRequest.params.get('age');
        String touristName = touristRequest.params.get('name');
        Integer touristAge;
        
        if (String.isEmpty(touristName) || String.isEmpty(touristAgeString) || !touristAgeString.isNumeric()) {
            if (String.isEmpty(touristName)) {
                String errorString = Constants.RESPONSE_BODY_EMPTY_NAME;
                response.responseBody = Blob.valueOf(errorString);
                response.statusCode = 404;
            } else if (String.isEmpty(touristAgeString)) {
                List<sObject> tourists = TouristManager.getByNameSosl(touristName);
                response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
                response.statusCode = 200;
            } else if (!touristAgeString.isNumeric()) {
                String errorString = Constants.RESPONSE_NOT_INTEGER_TYPE_AGE; 
                response.responseBody = Blob.valueOf(errorString);
                response.statusCode = 404;
            }
            return;
        }
        touristAge = Integer.valueOf(touristAgeString);
        List<sObject> tourists = TouristManager.getByParams(touristName, touristAge);    
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
    } 
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        Tourist__c newTourist = new Tourist__c(
            Name = name,
            Birthdate__c = Date.valueOf(birthday),
            Email__c = email
        );
        List<Tourist__c> tourists = TouristManager.getByResponseBody(name, email);
        
        if (!tourists.isEmpty()) {
            String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = 409;
            return;   
        }  
        insert newTourist;
        return;
    }    
}