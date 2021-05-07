@IsTest
private class TouristTriggerTest {
    
    @TestSetup
    private static void setup() {
        List<Flight__c> flightsToInsert = TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void testOnAfterInsert() {
        List<Tourist__c> oldTourists = TouristManager.getAllTourists();  
        Test.startTest(); 
        Database.SaveResult[] result = Database.insert(oldTourists, false);
        Test.stopTest();
        List<Tourist__c> tourisDuplicates = TouristManager.getDuplicateTourists();
        System.assertEquals(1, tourisDuplicates.size());
    }
    
    @IsTest
    private static void testOnAfterUpdate() {
        List<Tourist__c> tourists = TouristManager.getAllTourists();
        tourists[0].Active__c = false;
        Test.startTest();
        Database.SaveResult[] result = Database.update(tourists, false);
        Test.stopTest();
        List<Flight__c> flights = FlightManager.getFlights();
        System.assertEquals(Constants.FLIGHT_STATUS_DECLINED, flights[0].SecondStatus__c);
    }
}