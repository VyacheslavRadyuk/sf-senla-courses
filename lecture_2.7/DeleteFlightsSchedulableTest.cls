@IsTest
private class DeleteFlightsSchedulableTest {
    
    @IsTest
    private static void testschedule() {
        TestDataFactory.createFlights();
        DeleteFlightsSchedulable deleteFlights = new DeleteFlightsSchedulable();
        String sch = '0 0 0 * * ?'; 
        
        Test.StartTest();	
        System.schedule('Delete flights', sch, deleteFlights );
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
        
        List<AsyncApexJob> jobsApexBatch = [
            SELECT Id, 
            ApexClassID, 
            ApexClass.Name, 
            Status, 
            JobType 
            FROM AsyncApexJob 
            WHERE JobType = 'BatchApex'
        ];
        
        System.assertEquals(1, jobsScheduled.size());
        System.assertEquals('DeleteFlightsSchedulable', jobsScheduled[0].ApexClass.Name);  
        System.assertEquals(1, jobsApexBatch.size());
        System.assertEquals('DeleteFlightsBatch', jobsApexBatch[0].ApexClass.Name);        
    }
}