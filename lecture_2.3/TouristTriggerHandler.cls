public class TouristTriggerHandler {
    public static void afterInsert (List<Tourist__c> newTourists) {
        newTourists = [
            SELECT Name, 
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
    
    public static void afterUpdate (List<Tourist__c> checkActiveFields) {
        list<flight__c> ids = new list<flight__c>();
        
        for (Tourist__c a : checkActiveFields) {
            flight__c status = [
                SELECT Tourist__r.id,  
                Tourist__r.Active__c, 
                SecondStatus__c
                FROM flight__c
                WHERE Tourist__r.id = :a.Id
            ];
            
            if(!status.Tourist__r.Active__c) {
                status.SecondStatus__c = 'Declined';
                ids.add(status);
            }
        }
        update ids;
    }
}