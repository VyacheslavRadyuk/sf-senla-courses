public class WeatherForecastService {
    public class CustomException extends Exception {}
    
    public static  Map<Date, Decimal>  getForecasts(Decimal latitude, Decimal longitude) {   
        String apiKey = Constants.WEATHERBIT_API_KEY;
        String requestEndPoint = Constants.WEATHERBIT_END_POINT;
        requestEndPoint += '?lat=' + latitude;
        requestEndPoint += '&lon=' + longitude;
        requestEndPoint += '&key=' + apiKey;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(requestEndPoint);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
        Map<Date, Decimal> newMap = new Map<Date, Decimal>();
        
        try {
            if(response.getStatusCode() != 200) { 
                throw new CustomException(Constants.WEATHER_FORECAST_SERVICE_CUSTOM_EXCEPTION_ERROR);
            }
        } catch (CustomException ex) {
            System.debug(ex.getMessage());
        }
           
        if (response.getStatusCode() == 200) {
            Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
            List<Object> myMapObjects = (List<Object>) meta.get('data');
                  
            for (Integer i = 0; i < myMapObjects.size(); i++) {
                Map<String, Object> a2 = (Map<String, Object>)myMapObjects[i]; 
                newMap.put(date.valueOf(string.valueOf(a2.get('datetime'))), (decimal)(a2.get('temp')));                     
            }     
        }
        return newMap;
    }                         
}