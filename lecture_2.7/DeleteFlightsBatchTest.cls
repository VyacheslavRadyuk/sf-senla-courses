@IsTest
private class DeleteFlightsBatchTest {
    
    @IsTest
    private static void testExecuteBatch() {
        TestDataFactory.createFlights();
        DeleteFlightsBatch deleteFlights = new DeleteFlightsBatch();
        
        Test.startTest();     
        Database.executeBatch(deleteFlights);
        Test.stopTest();
                
        System.assertEquals(0, [SELECT count() FROM Flight__c WHERE SecondStatus__c = :Constants.FLIGHT_STATUS_DECLINED]);
    }
}