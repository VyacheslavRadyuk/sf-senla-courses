public class MetadataManager {
    
    public static List<Email__mdt> getEmail() {
        List<Email__mdt> email = [
            SELECT Id, 
            Email__c
            FROM Email__mdt 
            LIMIT 1
        ];
        return email;
    }
}