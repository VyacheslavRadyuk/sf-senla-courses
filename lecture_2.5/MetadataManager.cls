public class MetadataManager {
    
    public static Email__mdt getEmail() {
        Email__mdt email = [
            SELECT Id, 
            Email__c
            FROM Email__mdt 
            LIMIT 1
        ];
        return email;
    }
}