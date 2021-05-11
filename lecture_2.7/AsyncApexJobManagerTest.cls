@IsTest
private class AsyncApexJobManagerTest {
    private static final String DELETE_FLIGHTS_CLASS_COPY_NAME = 'Delete flights';
    private static final String DELETE_FLIGHTS_CLASS_NAME = 'DeleteFlightsBatch';
    private static final String CRON_EXPRESSION = '0 0 0 * * ?';
    
    @IsTest
    private static void testGetJobs() { 
        Set<Id> jobIds = new Set<Id>();
        TestDataFactory.createFlights();
        DeleteFlightsSchedulable deleteFlights = new DeleteFlightsSchedulable();
        
        Test.StartTest();	
        	String JobId = System.schedule(DELETE_FLIGHTS_CLASS_COPY_NAME, CRON_EXPRESSION, deleteFlights);
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
        List<AsyncApexJob> jobsApexBatch = AsyncApexJobManager.getById(jobIds);
        
        System.assertEquals(2, jobsApexBatch.size());
        System.assertEquals(DELETE_FLIGHTS_CLASS_NAME, jobsApexBatch[1].ApexClass.Name);  
    }
    
    @IsTest
    private static void testGetJobsNullParameter() {    
        List<AsyncApexJob> jobsNull = AsyncApexJobManager.getById(null); 
        
        System.assertEquals(0, jobsNull.size());  
    }
}