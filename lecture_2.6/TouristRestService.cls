@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAM_AGE = 'age';
    private static final String REQUEST_PARAM_NAME = 'name';
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String parameterAge = touristRequest.params.get(REQUEST_PARAM_AGE);
        String parameterName = touristRequest.params.get(REQUEST_PARAM_NAME);
        Boolean isValidation = String.isEmpty(parameterName) || String.isEmpty(parameterAge) || !parameterAge.isNumeric();
        
        if (isValidation) {
            TouristRestService.getTouristsValidationTrue(parameterName, parameterAge);
        } else {
            TouristRestService.getTouristsValidationFalse(parameterName, parameterAge);
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
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
            insert newTourist;
        }    
    }
    
    private static void getTouristsValidationTrue(String parameterName, String parameterAge) {
        RestResponse response = RestContext.response;  
        
        if (String.isEmpty(parameterName)) {
            String errorString = Constants.RESPONSE_BODY_EMPTY_NAME;
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
        } else if (String.isEmpty(parameterAge)) {
            List<Tourist__c> tourists = TouristManager.getByNameSosl(parameterName);
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        } else if (!parameterAge.isNumeric()) {
            String errorString = Constants.RESPONSE_NOT_INTEGER_TYPE_AGE; 
            response.responseBody = Blob.valueOf(errorString);
            response.statusCode = Constants.RESPONSE_STATUS_CODE_404;
        }            
    } 
    
    private static void getTouristsValidationFalse(String parameterName, String parameterAge) {
        RestResponse response = RestContext.response;
        Integer parameterAgeInteger = Integer.valueOf(parameterAge);
        List<Tourist__c> tourists = TouristManager.getByParams(parameterName, parameterAgeInteger);    
        response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
        response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
    }
    
    private static void createTouristValidationTrue() {
        RestResponse response = RestContext.response;
        String errorMessage = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
        response.responseBody = Blob.valueOf(errorMessage);
        response.statusCode = Constants.RESPONSE_STATUS_CODE_409;
    }
}