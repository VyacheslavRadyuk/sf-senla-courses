@IsTest
private class SpacePointManagerTest {
    
    @IsTest
    private static void testGetSpacePoints() {
        List<Space_Point__c> trips = TestDataFactory.createSpacePoints();
        List<Space_Point__c> tripsFromDb = SpacePointManager.getSpacePoints();
        
        System.assertEquals(2, tripsFromDb.size());
        System.assertNotEquals(null, tripsFromDb[0].Id);
        System.assertNotEquals(null, tripsFromDb[1].Id);       
    }
}