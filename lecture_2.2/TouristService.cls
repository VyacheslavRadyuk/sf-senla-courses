public class TouristService {
	public static void markDuplicates(List<Tourist__c> newTourists) {
	newTourists = [
            SELECT  Name, 
            Email__c, 
            IsDuplicate__c 
            FROM Tourist__c
        ];
        List<Tourist__c> firstTourists = new List<Tourist__c>();
        List<Tourist__c> secondTourists = new List<Tourist__c>();
        
        for (Tourist__c firstTourist: newTourists) {
            Integer coincidence = 0;
            
            for (Tourist__c secondTourist: newTourists) {
                
                if (firstTourist.Email__c == secondTourist.Email__c && firstTourist.Name == secondTourist.Name) {
                    coincidence++;
                    
                    if (coincidence > 1) {
                        firstTourist.IsDuplicate__c = false;
                        secondTourist.IsDuplicate__c = true;
                        firstTourists.add(firstTourist);
                        secondTourists.add(secondTourist);    
                    }
                }
            }
        }
        update firstTourists;
        update secondTourists;
        
        
    }

/* анонимус окно
 
Tourist__c n = new Tourist__c();
n.Name='Barsuk';
n.Birthdate__c = Date.newInstance(2000, 01, 28);
n.Email__c='vyacheslavradyuk@gmail.com';
List<Tourist__c> newTourists= new List<Tourist__c>();
insert n;
TouristService.markDuplicates(newTourists);
*/