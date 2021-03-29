public class AsynchTouristService {
    @future
    public static void markDuplicates(Set<Id> touristIds) {
        List<Tourist__c> newTourists = TouristManager.getById(touristIds);
        TouristService.markDuplicates(newTourists, touristIds);    
        update newTourists;
    }
}