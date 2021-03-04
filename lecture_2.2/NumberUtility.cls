public class NumberUtility {
    public static void methodOne (Integer N){
        List<Integer> primeNumbers = new List<Integer>();
        
		for (Integer i = 1; i <= N; i++) {
			Integer rez = i;
            
			for (integer j = 2; j < i; j++) {
                
				if (math.mod(i, j) == 0) {
					rez = null;
					break;
        		}
       		}
            
			if (rez != null) {
				primeNumbers.add(rez);
			}	  
		}	
			System.debug(primeNumbers);
    }
      
    public static void methodTwo (Integer N){
        List<Integer> primeNumbers = new List<Integer>();
			Integer n0 = 1;
			Integer n1 = 1;
			Integer n2;
			primeNumbers.add(n0);
			primeNumbers.add(n1);
        
		for (integer i = 3; i <= N; i++) {
			n2=n0+n1;
			primeNumbers.add(n2);
			n0=n1;
			n1=n2;
		}
		System.debug(primeNumbers);
    }
    
    public static void methodThree(Integer numToCheck ) {
		Integer result = 0;
        
			while (numToCheck > 0) {
    			 Integer ostatok = math.mod(numToCheck, 10);
    			 result = result * 10 + ostatok;
    			 numToCheck = numToCheck / 10;
                
    		if (numToCheck == result) {
        		 System.debug('polindrom');
        		 break;
   			}		
			}
        
			if (numToCheck != result) {
        		 System.debug(' no polindrom');
			}

    }
}