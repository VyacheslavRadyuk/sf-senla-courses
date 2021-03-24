public class ExceptionsPlayground {    
    public class CustomException extends Exception {}
    
    public static void generateCustomException() {
        Integer i = 0; 
        try {               
            if (i < 5) {
                throw new CustomException('Очень плохо!!!');
            }
        } catch(CustomException ex) {
            throw ex;
        }
    }  
    
    public static void generateRegularException() { 
        Integer i = 0;
        try {
           Integer b = 1 / i;
        } catch(MathException ex) {
            throw ex;
        }
    }
    
    public static void stopExceptions() {
        try{      
                ExceptionsPlayground.generateCustomException();
        } catch (Exception ex) {
            	System.debug('Исключениe 1 погашено!');
        }
         try{      
                ExceptionsPlayground.generateRegularException();
        } catch (Exception ex) {
            	System.debug('Исключениe 2 погашено!');
        }
    }
}