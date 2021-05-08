@IsTest
private class FlightManagerTest {
    private static List<Flight__c> flightsToInsert;
    
    static {
        flightsToInsert = TestDataFactory.createFlights();
    }
        
    @IsTest
    private static void testGetByYear() {
        List<Flight__c> flightFromDb = FlightManager.getByYear(2021);
        
        System.assertEquals(2, flightFromDb.size());
    }
    
    @IsTest
    private static void testGetByYearNullParameter() {
        List<Flight__c> flightFromDbNullYear = FlightManager.getByYear(null);
        List<Flight__c> flightFromDbZeroYear = FlightManager.getByYear(0);
        
        System.assertEquals(0, flightFromDbNullYear.size());
        System.assertEquals(0, flightFromDbZeroYear.size());
    }
    
    @IsTest
    private static void testGetFlights() {
        List<Flight__c> flightFromDb = FlightManager.getFlights();
        
        System.assertEquals(2, flightFromDb.size());
    }
    
    @IsTest
    private static void testGetByTouristsId() {
        Set<Id> touristsId = new Set<Id>();        
        
        for (Flight__c flight : flightsToInsert) {
            touristsId.add(flight.Tourist__c);
        }
        List<Flight__c> touristsFromDb = FlightManager.getByTouristsId(touristsId);
        
        System.assertEquals(2, touristsFromDb.size());
    }
    
    @IsTest
    private static void testGetByTouristsIdNullParameter() {
        List<Flight__c> touristsFromDbNull = FlightManager.getByTouristsId(null);
        
        System.assertEquals(0, touristsFromDbNull.size());
    }  
}