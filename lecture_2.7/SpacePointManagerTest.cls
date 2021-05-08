@IsTest
private class SpacePointManagerTest {
    
    @IsTest
    private static void testGetSpacePoints() {
        List<Space_Point__c> tripsToInsert = TestDataFactory.createSpacePoints();
        List<Space_Point__c> tripsFromDb = SpacePointManager.getSpacePoints();
        
        System.assertNotEquals(null, tripsFromDb);
        System.assertEquals(2, tripsFromDb.size());
        System.assertEquals(tripsToInsert[0].Id, tripsFromDb[0].Id);
        System.assertEquals(tripsToInsert[1].Id, tripsFromDb[1].Id);       
    }
}