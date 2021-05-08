@IsTest
private class MetadataManagerTest {
    
    @IsTest
    private static void testGetEmail() {
        List<Email__mdt> metaDataEmails = MetadataManager.getEmail();
        
        System.assertNotEquals(null, metaDataEmails);
        System.assertEquals(1, metaDataEmails.size());
    }
}