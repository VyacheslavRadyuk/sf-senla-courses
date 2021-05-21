@IsTest
public class WeatherForecastHttpCalloutMock implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();   
        response.setHeader('Content-Type', 'application/json');        
        response.setBody('{"data": [{"datetime" : "2021-05-20", "temp" : 2.5}]}');
        response.setStatusCode(200);                  
        return response; 
    } 
}