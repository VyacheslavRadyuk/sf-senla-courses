@IsTest
private class AsyncApexJobManagerTest {
    
    @IsTest
    static void testGetJobs() {
        List<AsyncApexJob> jobs = AsyncApexJobManager.getById(null);
        
        System.assertEquals(0, jobs.size());
    }
}