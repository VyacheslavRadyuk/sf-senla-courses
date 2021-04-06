public class TouristServiceAsynch {
    
    @future
    public static void markDuplicatesAsync(Set<Id> touristIds) {
        List<Tourist__c> newTourists = TouristManager.getById(touristIds);
        newTourists = TouristService.markDuplicates(newTourists, touristIds);    
        update newTourists;
    }
}