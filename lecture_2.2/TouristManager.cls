public class TouristManager {
    
    public static List<Tourist__c> methodOne(String name){
        List<Tourist__c> listOne = [SELECT Age__c, Name FROM Tourist__c WHERE Name = :name];
        System.debug(listOne);
        return listOne;
    }
    
    
    public static List<Tourist__c> methodTwo(Integer age){
        List<Tourist__c> listTwo = [SELECT Age__c, Name FROM Tourist__c WHERE Age__c = :age];
            system.debug(listTwo);
        	return listTwo;
        }
  
    public static List<Flight__c> methodThree(Integer year){
        List<Flight__c> listThree = [SELECT Tourist__r.Name, Tourist__r.Age__c FROM Flight__c WHERE CALENDAR_YEAR(Trip__r.Start_Date__c)>= :year];
        	System.debug(listThree);
        	return listThree;
      
    }

    public static List<Flight__c> methodFour(){
    	List<Flight__c> listFour = [SELECT Tourist__r.Name, Tourist__r.Age__c, Trip__r.Name, Trip__r.Start_Date__c FROM Flight__c];
 	    	System.debug(listFour);
        	return listFour;
       
    	}

    public static List<Tourist__c > methodFive(integer count){
        List<Tourist__c > listFive = [SELECT Name, Age__c FROM Tourist__c WHERE Upcoming_Flights_Count__c = :count];
        	System.debug(listFive);
        	return (listFive);

    }
}