@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAM_AGE = 'age';
    private static final String REQUEST_PARAM_NAME = 'name';
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String touristByAgeString = touristRequest.params.get(REQUEST_PARAM_AGE);
        String touristByName = touristRequest.params.get(REQUEST_PARAM_NAME);
        Boolean isValidation = String.isEmpty(touristByName) || String.isEmpty(touristByAgeString) || !touristByAgeString.isNumeric();
        
        if (isValidation) {
            TouristRestService.getTouristsValidationTrue(touristByName, touristByAgeString);
        } else {
            TouristRestService.getTouristsValidationFalse(touristByName, touristByAgeString);
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
            TouristRestService.createTouristValidationTrue();  
        } else {
            insert newTourist;
        }    
    }
    
    public static void getTouristsValidationTrue(String touristByName, String touristByAgeString) {
        RestResponse response = RestContext.response;  
        
        if (String.isEmpty(touristByName)) {
            String errorString = Constants.RESPONSE_BODY_EMPTY_NAME;
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
        } else if (String.isEmpty(touristByAgeString)) {
            List<Tourist__c> tourists = TouristManager.getByNameSosl(touristByName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        } else if (!touristByAgeString.isNumeric()) {
            String errorString = Constants.RESPONSE_NOT_INTEGER_TYPE_AGE; 
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
        }            
    } 
    
    public static void getTouristsValidationFalse(String touristByName, String touristByAgeString) {
        RestResponse response = RestContext.response;
        Integer touristByAge = Integer.valueOf(touristByAgeString);
        List<Tourist__c> tourists = TouristManager.getByParams(touristByName, touristByAge);    
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
    }
    
    public static void createTouristValidationTrue() {
        RestResponse response = RestContext.response;
        String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
        response.responseBody = Blob.valueOf(errorMessage);
        response.statusCode = Constants.RESPONSE_STATUS_CODE_409;
    }
}