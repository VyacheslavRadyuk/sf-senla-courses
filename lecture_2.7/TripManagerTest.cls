@IsTest
private class TripManagerTest {
    
    @TestSetup
    private static void setup() {
        List<Trip__c> tripsToInsert = TestDataFactory.createTrips();
    }
	
    @IsTest
    private static void testGetById() {
        List<Trip__c> tripsToInsert = TripManager.getTrips();
        Set<Id> tripsId  = new Set<Id>();
        
        for (Trip__c trip : tripsToInsert) {
            tripsId.add(trip.Id);
        }
        List<Trip__c> tripsDb = TripManager.getById(tripsId);
        System.assertEquals(2, tripsDb.size());        
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {
        List<Trip__c> tripsToInsert = TripManager.getTrips();
        List<Trip__c> tripsDbNull = TripManager.getById(null);   
        System.assertEquals(new List<Trip__c>(), tripsDbNull);     
    }
}