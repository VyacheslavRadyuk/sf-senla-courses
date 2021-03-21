public class TripFull {
    @InvocableMethod(label='autoCreateFlights' description='Сreation of flights if tourists are not registered')
    
    public static void autoCreateFlights(List<Trip__c> trip){
        
        List<Tourist__c> freeTourists = TouristManager.getFreeTourists();
        List<Flight__c> newFlights = new List<Flight__c>();        
         
        for (Tourist__c a : freeTourists) {
            if(a.Age__c > trip[0].Minimum_Age__c) {
            Flight__c createFlight = new Flight__c(
                Tourist__c = a.id,
                Trip__c = Trip[0].Id,
                Status__c = 'Preparing for departure'
            );
            newFlights.add(createFlight);
        }
        }
        insert newFlights; 
    }
}