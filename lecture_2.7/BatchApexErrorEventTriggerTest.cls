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
    }
}