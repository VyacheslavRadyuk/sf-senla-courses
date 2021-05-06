@IsTest
private class MetadataManagerTest {
    
    @IsTest
    static void testGetEmail() {
        List<Email__mdt> metaDataEmails = MetadataManager.getEmail();
        System.assertEquals(1, metaDataEmails.size());
    }
}