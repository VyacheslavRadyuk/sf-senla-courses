@IsTest
private class SpacePointManagerTest {
    
    @IsTest
    static void testGetSpacePoints() {
        List<Space_Point__c> tripsToInsert = TestDataFactory.createSpacePoints();
        List<Space_Point__c> tripsFromDb = SpacePointManager.getSpacePoints();
        
        System.assertEquals(2, tripsFromDb.size());     
    }
}