@IsTest
private class TouristManagerTest {
    private static final Integer AGE_PARTICULAR_TOURIST = 21;
    private static final String NAME_FIRST_NEW_TOURIST = 'Ivan';
    private static final String NAME_SECOND_NEW_TOURIST = 'Ivanovich';
    private static List<Tourist__c> tourists;
    
    static {
        tourists = TestDataFactory.createTourists();
    }
    
    @IsTest
    private static void testGetByName() {
        List<Tourist__c> touristsFromDb = TouristManager.getByName(tourists.get(0).Name);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(1, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
    }
    
     @IsTest
    private static void testGetByNameNullParameter() {
        List<Tourist__c> touristsFromDb = TouristManager.getByName(null);
        
        System.assertEquals(0, touristsFromDb.size());
    }
    
    @IsTest
    private static void testGetByAge() {
        Set<Integer> ages = new Set<Integer>();
        ages.add(AGE_PARTICULAR_TOURIST);
        List<Tourist__c> touristsFromDb = TouristManager.getByAge(ages);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(2, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
        System.assertNotEquals(null, touristsFromDb.get(1).Id);
    }
    
    @IsTest
    private static void testGetByAgeNullParameter() {
        List<Tourist__c> touristsFromDbNull = TouristManager.getByAge(null);
        
        System.assertEquals(0, touristsFromDbNull.size());
    }
    
    @IsTest
    private static void testGetByFlightsCount() {
        Integer count = 0;
        List<Tourist__c> touristsFromDb = TouristManager.getByFlightsCount(count);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(3, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
        System.assertNotEquals(null, touristsFromDb.get(1).Id);
        System.assertNotEquals(null, touristsFromDb.get(2).Id);
    }
    
    @IsTest
    private static void testGetTourists(){
        List<Tourist__c> newTouristToInsert = new List<Tourist__c> {
            new Tourist__c(Name = NAME_FIRST_NEW_TOURIST, birthdate__c = date.newInstance(2000,03,03)),
            new Tourist__c(Name = NAME_SECOND_NEW_TOURIST, birthdate__c = date.newInstance(2000,03,03))    
        };
        insert newTouristToInsert;
        List<String> oldNames = new List<String>();
        List<String> oldEmail = new List<String>();   
        Set<Id> newIds = new Set<Id>();
        
        for (Tourist__c newTourist : newTouristToInsert) {
            newIds.add(newTourist.Id);
        }
        
        for (Tourist__c oldTourist : tourists) {
            oldNames.add(oldTourist.Name);
            oldEmail.add(oldTourist.Email__c);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getTourists(oldNames, oldEmail, newIds);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(2, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
        System.assertNotEquals(null, touristsFromDb.get(1).Id);
    }
    
    @IsTest
    private static void testGetTouristsNullParameter(){
        List<Tourist__c> newTouristToInsert = new List<Tourist__c> {
            new Tourist__c(Name = NAME_FIRST_NEW_TOURIST, birthdate__c = date.newInstance(2000,03,03)),
            new Tourist__c(Name = NAME_SECOND_NEW_TOURIST, birthdate__c = date.newInstance(2000,03,03))    
        };
        insert newTouristToInsert;
        List<String> oldNames = new List<String>();
        List<String> oldEmail = new List<String>();   
        Set<Id> newIds = new Set<Id>();
        
        for (Tourist__c newTourist : newTouristToInsert) {
            newIds.add(newTourist.Id);
        }
        
        for (Tourist__c oldTourist : tourists) {
            oldNames.add(oldTourist.Name);
            oldEmail.add(oldTourist.Email__c);
        }
        List<Tourist__c> touristsFromDbNullNames = TouristManager.getTourists(null, oldEmail, newIds);
        List<Tourist__c> touristsFromDbNullEmails = TouristManager.getTourists(oldNames, null, newIds);
        List<Tourist__c> touristsFromDbNullNewIds = TouristManager.getTourists(oldNames, oldEmail, null);
        
        System.assertEquals(0, touristsFromDbNullNames.size());
        System.assertEquals(0, touristsFromDbNullEmails.size());
        System.assertEquals(0, touristsFromDbNullNewIds.size());
    }
    
    @IsTest
    private static void testGetFreeTourists() {
        List<Tourist__c> touristsFromDb = TouristManager.getFreeTourists();
        
        System.assertEquals(3, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
        System.assertNotEquals(null, touristsFromDb.get(1).Id);
        System.assertNotEquals(null, touristsFromDb.get(2).Id);
    }
    
    @IsTest
    private static void testGetById() {
        Set<Id> touristIds = new Set<Id>();
        
        for (Tourist__c tourist : tourists) {
            touristIds.add(tourist.Id);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getById(touristIds);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(3, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);
        System.assertNotEquals(null, touristsFromDb.get(1).Id);
        System.assertNotEquals(null, touristsFromDb.get(2).Id);
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {    
        List<Tourist__c> touristsFromDbNull = TouristManager.getById(null);
        
        System.assertEquals(true, touristsFromDbNull.isEmpty());
    }
    
    @IsTest
    private static void testGetByParams() {
        String touristName = tourists.get(0).Name;
        Integer touristAge = AGE_PARTICULAR_TOURIST;
        
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        Test.setFixedSearchResults(fixedSearchResults);
        
        List<Tourist__c> touristsFromDb = TouristManager.getByParams(touristName, touristAge);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(1, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    private static void testGetByParamsByllParameter() {
        String touristName = tourists.get(0).Name;
        Integer touristAge = AGE_PARTICULAR_TOURIST;
        
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        Test.setFixedSearchResults(fixedSearchResults);
        
        List<Tourist__c> touristsFromDbNullName = TouristManager.getByParams(null, touristAge);
        List<Tourist__c> touristsFromDbNullAge = TouristManager.getByParams(touristName, null);
         
        System.assertEquals(true, touristsFromDbNullName.isEmpty());  
        System.assertEquals(true, touristsFromDbNullAge.isEmpty());  
    }
    
    @IsTest
    private static void testGetByNameSosl() {
        String touristName = tourists.get(0).Name;
        
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = tourists[0].Id;
        Test.setFixedSearchResults(fixedSearchResults);
        
        List<Tourist__c> touristsFromDb = TouristManager.getByNameSosl(touristName);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(1, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    private static void testGetByNameSoslNullParameter() {
        List<Tourist__c> touristsFromDbNull = TouristManager.getByNameSosl(null);
        
        System.assertEquals(true, touristsFromDbNull.isEmpty());  
    }
    
    @IsTest
    private static void testGetByResponseBody() {
        String touristName = tourists.get(0).Name;
        String touristEmail = tourists.get(0).Email__c;   
        List<Tourist__c> touristsFromDb = TouristManager.getByResponseBody(touristName, touristEmail);
        
        System.assertNotEquals(null, touristsFromDb);
        System.assertEquals(1, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id);      
    }  
    
    @IsTest
    private static void testGetByResponseBodyNullParameter() {
        String touristName = tourists.get(0).Name;
        String touristEmail = tourists.get(0).Email__c;   
        List<Tourist__c> touristsFromDb = TouristManager.getByResponseBody(touristName, touristEmail);
        List<Tourist__c> touristsFromDbNullEmail = TouristManager.getByResponseBody(touristName, null);
        List<Tourist__c> touristsFromDbNullName = TouristManager.getByResponseBody(null, touristEmail);
        
        System.assertEquals(true, touristsFromDbNullEmail.isEmpty());
        System.assertEquals(true, touristsFromDbNullName.isEmpty());       
    }
    
    @IsTest
    private static void testGetNotRelatedTourists() { 
        List<Trip__c> trips = TestDataFactory.createTrips();
        List<Flight__c> flight = new List<Flight__c> {
           new Flight__c(Name = 'test1', Trip__c = trips[0].Id, Tourist__c = tourists[0].Id),
           new Flight__c(Name = 'test2', Trip__c = trips[1].Id, Tourist__c = tourists[0].Id)    
        };
        insert flight;
        List<Tourist__c> touristsFromDb = TouristManager.getNotRelatedTourists(trips[0].Id);
        
        System.assertEquals(2, touristsFromDb.size());
        System.assertNotEquals(null, touristsFromDb.get(0).Id); 
        System.assertNotEquals(null, touristsFromDb.get(1).Id);        
    }
    
    @IsTest
    private static void testGetNotRelatedTouristsNullParameter() {
        List<Tourist__c> touristsFromDb = TouristManager.getNotRelatedTourists(null);
        
        System.assertEquals(true, touristsFromDb.isEmpty());  
    }  
}