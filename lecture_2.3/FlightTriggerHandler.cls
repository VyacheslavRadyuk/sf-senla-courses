public class FlightTriggerHandler {
    public static void beforeInsert (List<Flight__c> newFlights) { 
        
        for (Flight__c a : newFlights) {
            
            Tourist__c tourists = [
                SELECT id, Age__c
                FROM Tourist__c
                WHERE id = :a.Tourist__c
            ];
            
            Trip__c trips = [
                SELECT id, Minimum_Age__c, Start_Date__c
                FROM Trip__c
                WHERE id = :a.Trip__c
            ];
            
            if (tourists.Age__c < trips.Minimum_Age__c) {
                a.Tourist__c.addError('Insufficient age');
            }
            
            if (trips.Start_Date__c < date.today()) {
                a.Trip__c.addError('The plane flew away');
            }
        }
    }
}