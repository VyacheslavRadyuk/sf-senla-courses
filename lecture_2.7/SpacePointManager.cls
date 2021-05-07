public class SpacePointManager {
    
    public static List<Space_Point__c> getSpacePoints() {
        List<Space_Point__c> listSpacePoints = [
            SELECT Id, 
            City__c, 
            Latitude__c, 
            Longitude__c 
            FROM Space_Point__c
        ];
        return listSpacePoints;
    }
}