@IsTest
private class TripManagerTest {
    private static List<Trip__c> trips;
    
    static {
        trips = TestDataFactory.createTrips();
    }
    
    @IsTest
    private static void testGetById() {
        Set<Id> tripsId  = new Set<Id>();
        
        for (Trip__c trip : trips) {
            tripsId.add(trip.Id);
        }
        List<Trip__c> tripsDb = TripManager.getById(tripsId);
        
        System.assertEquals(3, tripsDb.size());
        System.assertNotEquals(null, tripsDb[0].Id);
        System.assertNotEquals(null, tripsDb[1].Id);
        System.assertNotEquals(null, tripsDb[2].Id);    
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {
        List<Trip__c> tripsDbNull = TripManager.getById(null); 
        
        System.assertEquals(true, tripsDbNull.isEmpty());     
    }
}