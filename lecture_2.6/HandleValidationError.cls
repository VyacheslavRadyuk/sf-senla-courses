public class HandleValidationError {
    
    public static void validationByName(String name) {
        if (String.isEmpty(name)) {
            String errorMsg = Constants.RESPONSE_BODY_EMPTY_NAME;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(errorMsg, statusCode);
        }
    }
    
    public static void validationByAge(String age) {
        if (!String.isBlank(age) && !age.isNumeric()) {
            String message = Constants.RESPONSE_NOT_INTEGER_TYPE_AGE;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_404;
            throw new RestRequestValidationException(message, statusCode);
        }
    }
    
    public static void checkingDuplicateTourists(String name, String email) {
        List<Tourist__c> matchingTourists = TouristManager.getByResponseBody(name, email);
        if (!matchingTourists.isEmpty()) {
            String errorMsg = Constants.RESPONSE_BODY_DUPLICATE_RECORD;
            Integer statusCode = Constants.RESPONSE_STATUS_CODE_409;
            throw new RestRequestValidationException(errorMsg, statusCode);
        }
    }
}