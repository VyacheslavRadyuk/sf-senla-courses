@IsTest
private class TouristTriggerTest {
    private static List<Flight__c> flights;
    private static List<Tourist__c> tourists;
    
    static {
        flights = TestDataFactory.createFlights();
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
        
        System.assertEquals(1, getTouristDuplicates().size());
        System.assertEquals('Slava', getTouristDuplicates()[0].Name);
        System.assertEquals('vyacheslavradyuk@gmail.com', getTouristDuplicates()[0].Email__c);
    }
    
    @IsTest
    private static void testOnAfterInsertDuplicate() {
        Tourist__c createDuplicateTourist = new Tourist__c(Name = 'Sasha', Email__c = 'vyacheslavradyuk@gmail.com', IsDuplicate__c = true);
        insert createDuplicateTourist;
        
        Test.startTest(); 
        Database.SaveResult[] result = Database.insert(tourists, false);
        Test.stopTest();
        
        System.assertEquals(2, getTouristDuplicates().size()); 
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
    
    private static List<Tourist__c> getTouristDuplicates() {
        List<Tourist__c> touristDuplicates = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
            WHERE IsDuplicate__c = true
        ];
        return touristDuplicates;
    }
}