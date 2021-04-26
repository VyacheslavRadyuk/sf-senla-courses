public class WeatherForecastService {
    public class WeatherForecastException extends Exception {}
    
    public static  Map<Date, Decimal>  getForecasts(Decimal latitude, Decimal longitude) {   
        String apiKey = Constants.WEATHERBIT_API_KEY;
        String requestEndPoint = Constants.WEATHERBIT_END_POINT;
        requestEndPoint += '?lat=' + latitude;
        requestEndPoint += '&lon=' + longitude;
        requestEndPoint += '&key=' + apiKey;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod(Constants.HTTP_METHOD_GET);
        HTTPResponse response = http.send(request);
        Map<Date, Decimal> dataMap = new Map<Date, Decimal>();
        
        try {
            if(response.getStatusCode() != 200) { 
                throw new WeatherForecastException(Constants.WEATHER_FORECAST_SERVICE_CUSTOM_EXCEPTION_ERROR);
            } else {    
                if (response.getStatusCode() == 200) {
                    Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
                    List<Object> myMapObjects = (List<Object>) meta.get('data');
                    
                    for (Integer i = 0; i < myMapObjects.size(); i++) {
                        Map<String, Object> temporaryMap = (Map<String, Object>)myMapObjects[i]; 
                        dataMap.put(Date.valueOf(String.valueOf(temporaryMap.get('datetime'))), (Decimal)(temporaryMap.get('temp')));                     
                    }     
                }
            }
        } catch (WeatherForecastException ex) {
            throw ex;
        }
        system.debug(dataMap);
        return dataMap;
    }                         
}