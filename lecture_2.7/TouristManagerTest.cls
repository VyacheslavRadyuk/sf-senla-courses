@IsTest
private class TouristManagerTest {
    
    @IsTest
    static void testGetByName() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        List<Tourist__c> touristsFromDb = TouristManager.getByName(touristsToInsert.get(0).Name);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetByAge() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        Set<Integer> ages = new Set<Integer>();
        ages.add(21);
        List<Tourist__c> touristsFromDb = TouristManager.getByAge(ages);
        List<Tourist__c> touristsFromDbNull = TouristManager.getByAge(null);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(0, touristsFromDbNull.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetByFlightsCount() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        Integer count = 0;
        List<Tourist__c> touristsFromDb = TouristManager.getByFlightsCount(count);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetTourists(){
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        List<Tourist__c> newTouristToInsert = new List<Tourist__c> {
            new Tourist__c(Name = 'Ivan', birthdate__c = date.newInstance(2000,03,03)),
            new Tourist__c(Name = 'Ivanovich', birthdate__c = date.newInstance(2000,03,03))    
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
        List<Tourist__c> touristsFromDbNull = TouristManager.getTourists(null, null, null);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(0, touristsFromDbNull.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetFreeTourists() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        List<Tourist__c> touristsFromDb = TouristManager.getFreeTourists();
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetById() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        Set<Id> touristIds = new Set<Id>();
        
        for (Tourist__c tourist : touristsToInsert) {
            touristIds.add(tourist.Id);
        }
        List<Tourist__c> touristsFromDb = TouristManager.getById(touristIds);
        List<Tourist__c> touristsFromDbNull = TouristManager.getById(null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);
        System.assertEquals(2, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
    }
    
    @IsTest
    static void testGetByParams() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        String touristName = touristsToInsert.get(0).Name;
        Integer touristAge = 21;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = touristsToInsert[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsFromDb = TouristManager.getByParams(touristName, touristAge);
        List<Tourist__c> touristsFromDbNull = TouristManager.getByParams(null, null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    static void testGetByNameSosl() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        String touristName = touristsToInsert.get(0).Name;
        Id [] fixedSearchResults = new Id[1];
        fixedSearchResults[0] = touristsToInsert[0].Id;
        System.Test.setFixedSearchResults(fixedSearchResults);
        List<Tourist__c> touristsFromDb = TouristManager.getByNameSosl(touristName);
        List<Tourist__c> touristsFromDbNull = TouristManager.getByNameSosl(null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);   
    }
    
    @IsTest
    static void testGetByResponseBody() {
        List<Tourist__c> touristsToInsert = TestDataFactory.createTourists();
        String touristName = touristsToInsert.get(0).Name;
        String touristEmail = touristsToInsert.get(0).Email__c;   
        List<Tourist__c> touristsFromDb = TouristManager.getByResponseBody(touristName, touristEmail);
        List<Tourist__c> touristsFromDbNull = TouristManager.getByResponseBody(null, null);
        System.assertEquals(new List<Tourist__c>(), touristsFromDbNull);
        System.assertEquals(1, touristsFromDb.size());
        System.assertEquals(touristsToInsert.get(0).Id, touristsFromDb.get(0).Id);
        
    }  
}