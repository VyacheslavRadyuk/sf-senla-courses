@RestResource(urlMapping='/Tourist/*')
global with sharing class TouristRestService {
    private static final String REQUEST_PARAM_AGE = 'age';
    private static final String REQUEST_PARAM_NAME = 'fuzzyname';
    
    @HttpGet
    global static void getTourists() {    
        RestRequest touristRequest = RestContext.request;
        RestResponse response = RestContext.response;       
        String parameterAge = touristRequest.params.get(REQUEST_PARAM_AGE);
        String parameterName = touristRequest.params.get(REQUEST_PARAM_NAME);
        List<Tourist__c> tourists = new List<Tourist__c>();
        
        try{
            HandleValidationError.validationByName(parameterName);
            HandleValidationError.validationByAge(parameterAge);
            
            if (String.isBlank(parameterAge)) {
                tourists = TouristManager.getByNameSosl(parameterName);
            } else {
                Integer age = Integer.valueof(parameterAge);
                tourists = TouristManager.getByParams(parameterName, age);    
            }
            response.statusCode = Constants.RESPONSE_STATUS_CODE_200;
            response.responseBody = Blob.valueOf(JSON.serializePretty(tourists));
        } catch (RestRequestValidationException ex) {
            response.statusCode = ex.getStatusCode();
            response.responseBody = Blob.valueOf(ex.getMessage());
        } catch (Exception ex) {
            response.statusCode = 500;
            response.responseBody = Blob.valueOf(Constants.RESPONSE_BODY_INTERNAL_SERVER_ERROR);
        }
    }
    
    @HttpPost
    global static void createTourist(String name, String birthday, String email) {
        RestResponse response = RestContext.response;
        try{
            HandleValidationError.checkingDuplicateTourists(name, email);
            Tourist__c newTourist = new Tourist__c(
                Name = name,
                Birthdate__c = Date.valueOf(birthday),
                Email__c = email         
            );         
            response.statusCode = Constants.RESPONSE_STATUS_CODE_201;
            response.responseBody = Blob.valueOf(JSON.serializePretty(newTourist));
            insert newTourist;
        } catch (RestRequestValidationException ex) {
            response.statusCode = ex.getStatusCode();
            response.responseBody = Blob.valueOf(ex.getMessage());
        } catch (Exception ex) {
            response.statusCode = Constants.RESPONSE_STATUS_CODE_500;
            response.responseBody = Blob.valueOf(Constants.RESPONSE_BODY_INTERNAL_SERVER_ERROR);
        }
    }
}