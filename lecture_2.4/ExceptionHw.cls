public class ExceptionHw {    
    public class CusomException extends Exception {}
    
    public static void methodeOne() {
        Integer i = 0; 
        try {               
            if (i < 5) {
                throw new CusomException('Очень плохо!!!');
            }
        } catch(CusomException ex) {
            System.debug(ex.getMessage());
        }
    }  
    
    public static void methodeTwo() { 
        Integer i = 0;
        try {
           Integer b = 1 / i;
        } catch(MathException ex) {
            System.debug(ex.getMessage());
        }
    }
    
    public static void methodeThree() {
        try{
            integer i = 1;
            if(i >= 5 && i != 0) {
                ExceptionHw.methodeOne();
                ExceptionHw.methodeTwo();
            }
        } finally {
            System.debug('Исключения погашены');
        }
    }
}