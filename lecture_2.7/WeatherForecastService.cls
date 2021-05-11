public class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    private static final String META_DATA = 'data';
    private static final String META_DATA_DATETIME = 'datetime';
    private static final String META_DATA_TEMP = 'temp';
    
    public static  Map<Date, Decimal> getForecasts(Decimal latitude, Decimal longitude) {      
        String template = Constants.URL_TEMPLATE_WEATHERBIT_REMOTE_SITE;
        List<Object> parameters = new List<Object> {Constants.WEATHERBIT_NAMED_CREDENTIAL_END_POINT, latitude, longitude, Constants.WEATHERBIT_API_KEY};
            String url = String.format(template, parameters);
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod(Constants.HTTP_METHOD_GET);
        HTTPResponse response = http.send(request);
        Map<Date, Decimal> dataMap = new Map<Date, Decimal>();
        
        if(response.getStatusCode() != Constants.RESPONSE_STATUS_CODE_200) { 
            throw new WeatherForecastException(Constants.WEATHER_FORECAST_CUSTOM_EXCEPTION_ERROR);
        } else {    
            Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
            List<Object> myMapObjects = (List<Object>) meta.get(META_DATA);
            
            for (Integer i = 0; i < myMapObjects.size(); i++) {
                Map<String, Object> temporaryMap = (Map<String, Object>)myMapObjects[i]; 
                dataMap.put(Date.valueOf(String.valueOf(temporaryMap.get(META_DATA_DATETIME))), (Decimal)(temporaryMap.get(META_DATA_TEMP)));                     
            }     
        }
        return dataMap;    
    }                         
}