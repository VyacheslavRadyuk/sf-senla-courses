public class TouristManager {
    public static void methodOne(String name){
    	List<Tourist__c> listOne = [SELECT Age__c, Name FROM Tourist__c WHERE Name = :name];
        
        for (Tourist__c one: listOne){
           String result = 'Возраст: ' +  one.Age__c + '; ' + 'Имя: ' +  one.Name + ';'  ;
        System.debug(result);
        }
    }
    public static void methodTwo(Integer age){
        List<Tourist__c> listTwo = [SELECT Age__c, Name FROM Tourist__c WHERE Age__c = :age];
        
        for (Tourist__c two: listTwo){
            String result = 'Возраст: ' +  two.Age__c + '; ' + 'Имя: ' +  two.Name + ';'  ;
                system.debug(result);
        }
    }
    
    public static void methodThree(Integer year){
        List<Flight__c> listThree = [SELECT Tourist__r.Name, Tourist__r.Age__c FROM Flight__c WHERE CALENDAR_YEAR(Trip__r.Start_Date__c)>= :year];
        
        for (Flight__c three: listThree){
            String result = 'Возраст: ' +  three.Tourist__r.Age__c + '; ' + 'Имя: ' +  three.Tourist__r.Name + ';'  ;
            System.debug(result);
        }
    }
    public static  void methodFour(){
    	List<Flight__c> listFour = [SELECT Tourist__r.Name, Tourist__r.Age__c, Trip__r.Name, Trip__r.Start_Date__c FROM Flight__c];
 	    
        for (Flight__c four: listFour){
        	String result = 'Возраст туриста: ' +  four.Tourist__r.Age__c + '; ' + 'Имя туриста: ' +  four.Tourist__r.Name + ';' + 
                			'Название рейса: ' + four.Trip__r.Name + 'Дата рейса: ' + four.Trip__r.Start_Date__c ;
            System.debug(result);
        }
    	}
    public static void methodFive(integer count){
        List<Tourist__c > listFive = [SELECT Name, Age__c FROM Tourist__c WHERE Upcoming_Flights_Count__c = :count];
        
        for (Tourist__c five: listFive){
            String result = 'Не зарегистрировались на рейс: ' + five.Name + ' ' + 'Возраст: ' + five.Age__c ;
            System.debug(result);
        }
    }
}