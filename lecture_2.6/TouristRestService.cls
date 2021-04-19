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
}