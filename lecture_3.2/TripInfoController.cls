public class TripInfoController{
    public Trip__c trip;
    public List<Tourist__c> notRelatedTourists {get;set;}
    
    public TripInfoController(ApexPages.StandardController stdController) {
        this.trip = (Trip__c)stdController.getrecord();
        this.notRelatedTourists = TouristManager.getNotRelatedTourists(trip.Id);
    }
}