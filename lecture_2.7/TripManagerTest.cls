@IsTest
private class TripManagerTest {
    private static List<Trip__c> tripsToInsert;
    
    static {
        tripsToInsert = TestDataFactory.createTrips();
    }
    
    @IsTest
    private static void testGetById() {
        Set<Id> tripsId  = new Set<Id>();
        
        for (Trip__c trip : tripsToInsert) {
            tripsId.add(trip.Id);
        }
        List<Trip__c> tripsDb = TripManager.getById(tripsId);
        
        System.assertEquals(3, tripsDb.size());        
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {
        List<Trip__c> tripsDbNull = TripManager.getById(null); 
        
        System.assertEquals(new List<Trip__c>(), tripsDbNull);     
    }
}