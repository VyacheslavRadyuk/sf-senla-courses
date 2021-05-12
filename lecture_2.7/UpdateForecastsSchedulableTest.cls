@IsTest
private class UpdateForecastsSchedulableTest {
    
    @IsTest
    private static void testschedule() {
        TestDataFactory.createFlights();
        UpdateForecastsSchedulable updateForecasts = new UpdateForecastsSchedulable();
        String sch = '0 0 0 * * ?'; 
        
        Test.StartTest();	
        System.schedule('Update weather forecast', sch, updateForecasts );
        Test.stopTest();       
        
        List<AsyncApexJob> jobsScheduled  = [
            SELECT Id, 
            ApexClassID, 
            ApexClass.Name, 
            Status, 
            JobType 
            FROM AsyncApexJob 
            WHERE JobType = 'ScheduledApex'
        ];       
        
        System.assertEquals(1, jobsScheduled.size());
        System.assertEquals('UpdateForecastsSchedulable', jobsScheduled[0].ApexClass.Name);         
    }
}