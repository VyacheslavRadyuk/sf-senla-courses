public class PriceListOfTripsController {
    public String tourist;
    public List<Trip__c> trips{get;set;}
    public List<PriceBookEntry> prices{get;set;}
    
    public PriceListOfTripsController(ApexPages.StandardController stdController) {  
        this.tourist = ApexPages.CurrentPage().getparameters().get('Id');
        this.trips = TouristAssignmentController.getTrips(tourist); 
		this.trips.sort();
        List<String> tripNames = new List<String>(); 
                
        for (Trip__c trip : trips) {
            tripNames.add(trip.Name);
        }
        
        prices = [
            SELECT Name,
            UnitPrice
            FROM PriceBookEntry
            WHERE Name IN : tripNames
            ORDER BY Name
        ];
    }
}