@IsTest
private class BatchApexErrorEventTriggerTest {
    @testVisible private static List<BatchApexErrorEvent> eventList = new List<BatchApexErrorEvent>();
    
    @IsTest
    public static void testOnAfterInsert() {
        BatchApexErrorEvent eve = new BatchApexErrorEvent(AsyncApexJobId = '7075g000007wpcm' ,JobScope = 'a0D5g000000qgth', ExceptionType = 'System.MathException');
        eventList.add(eve);
        
        Test.startTest();
        Database.SaveResult[] sr = EventBus.publish(eventList);
        Test.stopTest();
        
        List<Error_Log__c> errors = [SELECT Records__c, JobId__c, Error__c FROM Error_Log__c];
           
        System.assertEquals(true, sr[0].isSuccess());
        System.assertEquals(1, errors.size());
        System.assertNotEquals(null, errors);
        System.assertEquals(errors[0].JobId__c, eve.AsyncApexJobId);
        System.assertEquals(errors[0].Error__c, eve.ExceptionType);
    }
}