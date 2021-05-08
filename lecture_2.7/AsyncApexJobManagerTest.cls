@IsTest
private class AsyncApexJobManagerTest {
    
    @IsTest
    private static void testGetJobs() { 
        Set<Id> jobIds = new Set<Id>();
        TestDataFactory.createFlights();
        DeleteFlightsSchedulable deleteFlights = new DeleteFlightsSchedulable();
        String sch = '0 0 0 * * ?'; 
        
        Test.StartTest();	
        String JobId = System.schedule('Delete flights', sch, deleteFlights);
        Test.stopTest();  
         
        List<AsyncApexJob> jobs  = [
            SELECT Id, 
            ApexClassID, 
            ApexClass.Name, 
            Status, 
            JobType 
            FROM AsyncApexJob 
        ];
        
        for (AsyncApexJob job : jobs) {
            jobIds.add(job.Id);
        }   
        List<AsyncApexJob> jobsNull = AsyncApexJobManager.getById(null); 
        List<AsyncApexJob> jobsApexBatch = AsyncApexJobManager.getById(jobIds);
        
        System.assertEquals(0, jobsNull.size());
        System.assertEquals(2, jobsApexBatch.size());
        System.assertEquals('DeleteFlightsBatch', jobsApexBatch[1].ApexClass.Name);  
    }
}
