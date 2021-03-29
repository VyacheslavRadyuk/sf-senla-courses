public class TouristService {
    public static List<Tourist__c> markDuplicates(List<Tourist__c> newTourists) {    
        
        if (!newTourists.isEmpty() && newTourists != null) {
            List<String> nameList = new List<String>();
            List<String> emailList = new List<String>();
            
            for (Tourist__c names : newTourists ) {
                nameList.add(names.Name);
            }
            
            for (Tourist__c emails : newTourists ) {
                emailList.add(emails.Email__c);
            }
            List<Tourist__c> oldTourists = TouristManager.getTourists(nameList, emailList);
            
            for (Tourist__c newTourist : newTourists) {
                
                for (Tourist__c Tourist: oldTourists) {
                    
                    if (Tourist.Email__c == newTourist.Email__c && Tourist.Name == newTourist.Name) {
                        newTourist.IsDuplicate__c = true;  
                    } 
                }
            }   
        }
        return newTourists;
    }
}