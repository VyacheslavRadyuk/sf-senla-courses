public class TouristService {
    public static void markDuplicates(List<Tourist__c> newTourists) {
        List<Tourist__c> oldTourists = TouristManager.getTourists();
        
        if (!newTourists.isEmpty() && newTourists != null) {
            
            for (Tourist__c newTourist : newTourists) {
                
                for (Tourist__c Tourist: oldTourists) {
                    
                    if (Tourist.Email__c == newTourist.Email__c && Tourist.Name == newTourist.Name) {
                        newTourist.IsDuplicate__c = true;  
                    } 
                }
            }        
        }
        insert newTourists;
    }
}

/*List<Tourist__c> newTourists= new List<Tourist__c>();
Tourist__c n = new Tourist__c();
n.Name='Barsuk';
n.Birthdate__c = Date.newInstance(2000, 01, 28);
n.Email__c='vyacheslavradyuk@gmail.com';
Tourist__c c = new Tourist__c();
c.Name='Barsuk';
c.Birthdate__c = Date.newInstance(2000, 01, 28);
c.Email__c='vyacheslavradyuk@mail.ru';
newTourists.add(n);
newTourists.add(c);
TouristService.markDuplicates(newTourists);
*/