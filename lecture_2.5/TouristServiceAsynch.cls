public class TouristServiceFuture {
    
    @future
    public static void markDuplicates(Set<Id> touristIds) {
        List<Tourist__c> newTourists = TouristManager.getById(touristIds);
        newTourists = TouristService.markDuplicates(newTourists, touristIds);    
        update newTourists;
    }
}