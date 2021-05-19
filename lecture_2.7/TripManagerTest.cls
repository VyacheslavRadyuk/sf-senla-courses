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
        
        System.assertNotEquals(null, tripsDb);
        System.assertEquals(3, tripsDb.size());
        System.assertEquals(tripsToInsert[0].Id, tripsDb[0].Id);
        System.assertEquals(tripsToInsert[1].Id, tripsDb[1].Id);
        System.assertEquals(tripsToInsert[2].Id, tripsDb[2].Id);    
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {
        List<Trip__c> tripsDbNull = TripManager.getById(null); 
        
        System.assertEquals(true, tripsDbNull.isEmpty());     
    }
}