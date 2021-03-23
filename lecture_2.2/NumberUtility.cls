public class NumberUtility {
    public static List<Integer> getPrimeNumbers (Integer n){
        List<Integer> primeNumbers = new List<Integer>();
        
        for (Integer i = 1; i <= N; i++) {
            Integer rez = i;
            
            for (integer j = 2; j < i; j++) {
                
                if (math.mod(i, j) == 0) {
                    rez = null;					
                }
            }
            
            if (rez != null) {
                primeNumbers.add(rez);
            }	  
        }	
        return primeNumbers;
    }
    
    public static List<Integer> getFibonacciNumbers (Integer n){
        List<Integer> fiboNumbers = new List<Integer>();
        Integer n0 = 1;
        Integer n1 = 1;
        Integer n2;
        fiboNumbers.add(n0);
        fiboNumbers.add(n1);
        
        for (integer i = 3; i <= N; i++) {
            n2=n0+n1;
            fiboNumbers.add(n2);
            n0=n1;
            n1=n2;
        }
        return fiboNumbers;
    }
    
    public static Boolean isPolyndrome(Integer numToCheck ) {
        Integer result = 0;
        Boolean polindromOrNo;
        while (numToCheck > 0) {
            Integer ostatok = math.mod(numToCheck, 10);
            result = result * 10 + ostatok;
            numToCheck = numToCheck / 10;
            
            if (numToCheck == result) {
                polindromOrNo = true;
                break;
            }		
        }
        
        if (numToCheck != result) {
            polindromOrNo = false;
        }
        return polindromOrNo;
    }
}