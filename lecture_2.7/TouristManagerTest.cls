@IsTest
private class TouristManagerTest {
    private static final Integer AGE_PARTICULAR_TOURIST = 21;
    private static final String NAME_FIRST_NEW_TOURIST = 'Ivan';
    private static final String NAME_SECOND_NEW_TOURIST = 'Ivanovich';
    
    @TestSetup
    private static void setup() {
        List<Flight__c> touristsToInsert = TestDataFactory.createFlights();
    }
    
    @IsTest
    private static void testGetByName() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        List<Tourist__c> touristsFromDb = TouristManager.getByName(touristsToInsert.get(0).Name);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
     @IsTest
    private static void testGetByNameNullParameter() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        List<Tourist__c> touristsFromDb = TouristManager.getByName(null);
        System.assertEquals(0, touristsFromDb.size());
    }
    
    @IsTest
    private static void testGetByAge() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        Set<Integer> ages = new Set<Integer>();
        ages.add(AGE_PARTICULAR_TOURIST);
        List<Tourist__c> touristsFromDb = TouristManager.getByAge(ages);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    private static void testGetByAgeNullParameter() {
        List<Tourist__c> touristsFromDbNull = TouristManager.getByAge(null);
        System.assertEquals(0, touristsFromDbNull.size());
    }
    
    @IsTest
    private static void testGetByFlightsCount() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        Integer count = 0;
        List<Tourist__c> touristsFromDb = TouristManager.getByFlightsCount(count);
        System.assertEquals(3, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    private static void testGetTourists(){
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
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
        
        for (Tourist__c oldTourist : touristsToInsert) {
            oldNames.add(oldTourist.Name);
            oldEmail.add(oldTourist.Email__c);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getTourists(oldNames, oldEmail, newIds);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    private static void testGetTouristsNullParameter(){
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
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
        
        for (Tourist__c oldTourist : touristsToInsert) {
            oldNames.add(oldTourist.Name);
            oldEmail.add(oldTourist.Email__c);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getTourists(oldNames, oldEmail, newIds);
        List<Tourist__c> touristsFromDbNullNames = TouristManager.getTourists(null, oldEmail, newIds);
        List<Tourist__c> touristsFromDbNullEmails = TouristManager.getTourists(oldNames, null, newIds);
        List<Tourist__c> touristsFromDbNullNewIds = TouristManager.getTourists(oldNames, oldEmail, null);
        System.assertEquals(0, touristsFromDbNullNames.size());
        System.assertEquals(0, touristsFromDbNullEmails.size());
        System.assertEquals(0, touristsFromDbNullNewIds.size());
    }
    
    @IsTest
    private static void testGetFreeTourists() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        List<Tourist__c> touristsFromDb = TouristManager.getFreeTourists();
        System.assertEquals(3, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    private static void testGetById() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        Set<Id> touristIds = new Set<Id>();
        
        for (Tourist__c tourist : touristsToInsert) {
            touristIds.add(tourist.Id);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getById(touristIds);
        System.assertEquals(3, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    private static void testGetByIdNullParameter() {    
        List<Tourist__c> touristsFromDbNull = TouristManager.getById(null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);
    }
    
    @IsTest
    private static void testGetByParams() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        String touristName = touristsToInsert.get(0).Name;
        Integer touristAge = AGE_PARTICULAR_TOURIST;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = touristsToInsert[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsFromDb = TouristManager.getByParams(touristName, touristAge);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    private static void testGetByParamsByllParameter() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        String touristName = touristsToInsert.get(0).Name;
        Integer touristAge = AGE_PARTICULAR_TOURIST;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = touristsToInsert[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsFromDbNullName = TouristManager.getByParams(null, touristAge);
        List<Tourist__c> touristsFromDbNullAge = TouristManager.getByParams(touristName, null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNullName);  
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNullAge);  
    }
    
    @IsTest
    private static void testGetByNameSosl() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        String touristName = touristsToInsert.get(0).Name;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = touristsToInsert[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsFromDb = TouristManager.getByNameSosl(touristName);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    private static void testGetByNameSoslNullParameter() {
        List<Tourist__c> touristsFromDbNull = TouristManager.getByNameSosl(null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);  
    }
    
    @IsTest
    private static void testGetByResponseBody() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        String touristName = touristsToInsert.get(0).Name;
        String touristEmail = touristsToInsert.get(0).Email__c;   
        List<Tourist__c> touristsFromDb = TouristManager.getByResponseBody(touristName, touristEmail);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
        
    }  
    
    @IsTest
    private static void testGetByResponseBodyNullParameter() {
        List<Tourist__c> touristsToInsert = TouristManager.getAllTourists();
        String touristName = touristsToInsert.get(0).Name;
        String touristEmail = touristsToInsert.get(0).Email__c;   
        List<Tourist__c> touristsFromDb = TouristManager.getByResponseBody(touristName, touristEmail);
        List<Tourist__c> touristsFromDbNullEmail = TouristManager.getByResponseBody(touristName, null);
        List<Tourist__c> touristsFromDbNullName = TouristManager.getByResponseBody(null, touristEmail);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNullEmail);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNullName);
        
    }  
}