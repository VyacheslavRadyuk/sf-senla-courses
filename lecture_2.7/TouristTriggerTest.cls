@IsTest
private class TouristTriggerTest {
    private static List<Flight__c> flightsToInsert;
    private static List<Tourist__c> tourists;
    
    static {
        flightsToInsert = TestDataFactory.createFlights();
        tourists = [
            SELECT Id,
            Name, 
            Age__c,
            Email__c
            FROM Tourist__c 
        ];  
    }
    
    @IsTest
    private static void testOnAfterInsert() {         
        Test.startTest(); 
        Database.SaveResult[] result = Database.insert(tourists, false);
        Test.stopTest();
        
        List<Tourist__c> touristDuplicates = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
            WHERE IsDuplicate__c = true
        ];
        
        System.assertEquals(1, touristDuplicates.size());
    }
    
    @IsTest
    private static void testOnAfterUpdate() {
        tourists[0].Active__c = false;
        
        Test.startTest();
        Database.SaveResult[] result = Database.update(tourists, false);
        Test.stopTest();
        
        List<Flight__c> flights = FlightManager.getFlights();
        
        System.assertEquals(Constants.FLIGHT_STATUS_DECLINED, flights[0].SecondStatus__c);
    }
}