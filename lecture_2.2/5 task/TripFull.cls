public class TripFull {
    @InvocableMethod(label='autoCreateFlights' description='Сreation of flights if tourists are not registered')
    
    public static void autoCreateFlights(List<Trip__c> trip){
        
        List<Tourist__c> freeTourists = [
            SELECT Id
            FROM Tourist__c
            WHERE Age__c > :trip[0].Minimum_Age__c AND Upcoming_Flights_Count__c = 0
        ];
        List<Flight__c> newFlights = new List<Flight__c>();        
        
        for (Tourist__c a : freeTourists) {
            Flight__c createFlight = new Flight__c(
                Tourist__c = a.id,
                Trip__c = Trip[0].Id,
                Status__c = 'Preparing for departure'
            );
            newFlights.add(createFlight);
        }
        insert newFlights; 
    }
}


