public class Constants {
    public static final String FLIGHT_STATUS_DECLINED = 'Declined';
    public static final String MAIL_SUBJECT = 'Batch was completed';
    public static final String MAIL_HTML_BODY = 'Tourists and the number of canceled flights for each of them:';
    public static final Integer FLIGHT_DELETION_PERIOD = 30;
    public static final String RESPONSE_BODY_EMPTY_NAME = 'The name must be not empty';
    public static final String RESPONSE_NOT_INTEGER_TYPE_AGE = 'The age must be a number';
    public static final String RESPONSE_BODY_INTERNAL_SERVER_ERROR = 'Internal server Error';
    public static final String RESPONSE_BODY_DUPLICATE_RECORD = 'This tourist is already in the database';
    public static final String WEATHERBIT_API_KEY = 'e522f7f77d114325939fa1492206cb01';
    public static final String WEATHERBIT_NAMED_CREDENTIAL_END_POINT = 'callout:Weatherbit_Endpoint';
    public static final String WEATHER_FORECAST_CUSTOM_EXCEPTION_ERROR = 'An error occurred in the callout process, or the responsive returned with an error!!!';
    public static final String HTTP_METHOD_GET = 'GET';
    public static final String URL_TEMPLATE_WEATHERBIT_REMOTE_SITE = '{0}?lat={1}&lon={2}&key={3}';
    public static final Integer RESPONSE_STATUS_CODE_200 = 200;
    public static final Integer RESPONSE_STATUS_CODE_201 = 201;
    public static final Integer RESPONSE_STATUS_CODE_404 = 404;
    public static final Integer RESPONSE_STATUS_CODE_409 = 409;
    public static final Integer RESPONSE_STATUS_CODE_500 = 500;
    public static final String TRIP_PLANE_FLEW_AWAY_ERROR = 'The plane flew away';
    public static final String TRIP_INSUFFICIENT_AGE_ERROR = 'Insufficient age';
    public static final String FLIGHT_SECOND_STATUS_OFFER_PENDING = 'Offer Pending';
    public static final String ASSIGN_SCREEN_ERROR_MSG_MISSING_TRIP_ID = System.Label.assignScreenErrorMissingTripId;
    public static final String ASSIGN_SCREEN_ERROR_MSG_NO_TOURISTS_SELECTED = System.Label.flightCreationErrorNoTouristSelected;
    public static final String ASSIGN_SCREEN_ERROR_MSG_NO_TRIPS_SELECTED = System.Label.flightCreationErrorNoTripsSelected;
    public static final String UNEXPECTED_ERROR_CONTACT_SYSTEM_ADMINISTRATOR = 'UNEXPECTED ERROR, CONTACT YOUR SYSTEM ADMINISTRATOR';
}