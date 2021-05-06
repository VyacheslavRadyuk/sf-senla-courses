@IsTest
private class FlightManagerTest {
    
    @IsTest
    static void testGetByYear() {
        List<Flight__c> flightsToInsert = TestDataFactory.createFlights();
        List<Flight__c> flightFromDb = FlightManager.getByYear(2021);
        List<Flight__c> flightFromDbNullYear = FlightManager.getByYear(null);
        List<Flight__c> flightFromDbZeroYear = FlightManager.getByYear(0);   
        System.assertEquals(2, flightFromDb.size());
        System.assertEquals(0, flightFromDbNullYear.size());
        System.assertEquals(0, flightFromDbZeroYear.size());
    }
    
    @IsTest
    static void testGetFlights() {
        List<Flight__c> flightsToInsert = TestDataFactory.createFlights();
        List<Flight__c> flightFromDb = FlightManager.getFlights();
        System.assertEquals(2, flightFromDb.size());
    }
    
    @IsTest
    static void testGetByTouristsId() {
        List<Flight__c> flightsToInsert = TestDataFactory.createFlights();
        Set<Id> touristsId = new Set<Id>();        
        
        for (Flight__c flight : flightsToInsert) {
            touristsId.add(flight.Tourist__c);
        }
        List<Flight__c> touristsFromDb = FlightManager.getByTouristsId(touristsId);
        List<Flight__c> touristsFromDbNull = FlightManager.getByTouristsId(null);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(0, touristsFromDbNull.size());
    }  
}