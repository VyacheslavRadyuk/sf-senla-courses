public class ExceptionHw {    
    public class CusomException extends Exception {}
    
    public static void methodeOne() {  
        try {
            Integer i = 0;         
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
            i = 1 / 0;
        } catch(MathException ex) {
            System.debug(ex.getMessage());
        }
    }
    
    public static void methodeThree(){
        
        ExceptionHw.methodeOne();
        ExceptionHw.methodeTwo();
    }
}