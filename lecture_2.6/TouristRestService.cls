@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String touristAgeString = touristRequest.params.get('age');
        String touristName = touristRequest.params.get('name');
        Integer touristAge;
        
        if(String.isEmpty(touristName)) {
            String errorString = constants.RESPONSE_BODY_EMPTY_NAME;
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = 404;
            return;
        } 
        
        if (String.isEmpty(touristAgeString)) {
            List<Tourist__c> touristList = TouristManager.getByName(touristName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(touristList));
            return;
        }
        
        try {
            touristAge = Integer.valueOf(touristAgeString);
        } catch (IllegalArgumentException e) {
            List<Tourist__c> touristList = TouristManager.getByName(touristName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(touristList));
            return;
        } catch (TypeException ex) {
            touristAge = (Integer)touristAge;
            String errorString = constants.RESPONSE_NOT_INTEGER_TYPE_AGE; 
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = 404;
            return; 
        }         
        List<List<sObject>> touristList = TouristManager.getByParams(touristName, touristAge);    
        response.statusCode = 200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(touristList));
    } 
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        Tourist__c thisTourist = new Tourist__c(
            Name = name,
            Birthdate__c = date.valueOf(birthday),
            Email__c = email
        );
        List<Tourist__c> touristsList = TouristManager.getByResponseBody(name, email);
        
        if (!touristsList.isEmpty()) {
            String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
            response.responseBody = Blob.valueOf(errorMessage);
            response.statusCode = 409;
            return;   
        }  
        insert thisTourist;
        return;
    }    
}