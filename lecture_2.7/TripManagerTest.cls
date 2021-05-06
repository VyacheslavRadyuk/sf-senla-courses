@IsTest
private class TripManagerTest {
	
    @IsTest
    static void testGetById() {
        List<Trip__c> tripsToInsert = TestDataFactory.createTrips();
        Set<Id> tripsId  = new Set<Id>();
        
        for (Trip__c trip : tripsToInsert) {
            tripsId.add(trip.Id);
        }
        List<Trip__c> tripsDb = TripManager.getById(tripsId);
        List<Trip__c> tripsDbNull = TripManager.getById(null);
        System.assertEquals(2, tripsDb.size());   
        System.assertEquals(new List<Trip__c>(), tripsDbNull);
        
    }
}