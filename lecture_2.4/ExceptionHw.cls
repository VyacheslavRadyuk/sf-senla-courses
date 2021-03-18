public class ExceptionHw {    
    public class CusomException extends Exception {}
    
    public static void methodeOne() {
        Integer i = 0; 
        try {               
            if (i < 5) {
                throw new CusomException('Очень плохо!!!');
            }
        } catch(CusomException ex) {
            throw ex;
        }
    }  
    
    public static void methodeTwo() { 
        Integer i = 0;
        try {
           Integer b = 1 / i;
        } catch(MathException ex) {
            throw ex;
        }
    }
    
    public static void methodeThree() {
        try{      
                ExceptionHw.methodeOne();
        } catch (Exception ex) {
            	System.debug('Исключениe 1 погашено!');
        }
         try{      
                ExceptionHw.methodeTwo();
        } catch (Exception ex) {
            	System.debug('Исключениe 2 погашено!');
        }
    }
}

