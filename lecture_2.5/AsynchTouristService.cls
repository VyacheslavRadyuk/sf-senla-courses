public class AsynchTouristService {
    public static void markDuplicates(Set<Id> touristIds) {
        List<Tourist__c> newTourists = TouristManager.getByIds(touristIds);
        TouristService.markDuplicates(newTourists);
        update newTourists;
    }
}