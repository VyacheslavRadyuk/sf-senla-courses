@IsTest
private class FlightTriggerTest {
    private static final String TOURIST_NAME = '777';
      
    @IsTest
    static void testBeforeInsertSuccess() {
        Tourist__c tourist =  TestDataFactory.createTourists()[1];
        Trip__c trip =  TestDataFactory.createTrips()[1];
        Flight__c flight = new Flight__c(Name = TOURIST_NAME, Tourist__c = tourist.Id, Trip__c = trip.Id); 
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);    
        Test.stopTest(); 
        
        System.assert(result.isSuccess()); 
    }
    
    @IsTest
    static void testBeforeInsertInsufficientAgeError() {
        Tourist__c tourist =  TestDataFactory.createTourists()[2];
        Trip__c trip =  TestDataFactory.createTrips()[2];
        Flight__c flight = new Flight__c(Name = TOURIST_NAME, Tourist__c = tourist.Id, Trip__c = trip.Id); 
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);    
        Test.stopTest(); 
        
        System.assert(!result.isSuccess());
        System.assertEquals(Constants.TRIP_PLANE_FLEW_AWAY_ERROR, result.getErrors()[0].getMessage());
    }
    
    @IsTest
    static void testBeforeInsertFlewAwayError() {
        Tourist__c tourist =  TestDataFactory.createTourists()[2];
        Trip__c trip =  TestDataFactory.createTrips()[1];
        Flight__c flight = new Flight__c(Name = TOURIST_NAME, Tourist__c = tourist.Id, Trip__c = trip.Id); 
        
        Test.startTest();
        Database.SaveResult result = Database.insert(flight, false);    
        Test.stopTest(); 
        
        System.assert(!result.isSuccess());
        System.assertEquals(Constants.TRIP_INSUFFICIENT_AGE_ERROR, result.getErrors()[0].getMessage());
    }
}