@IsTest
global class WeatherForecastHttpCalloutMock implements HttpCalloutMock {
    public static String successIndicator;
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');        
        response.setBody('{"data": [{"datetime" : "2021-05-20", "temp" : 2.5}]}');
        if(successIndicator == 'success') {
            response.setStatusCode(200);
        } else if (successIndicator == 'noSuccess') {
            response.setStatusCode(404);
        }               
        return response; 
    } 
}