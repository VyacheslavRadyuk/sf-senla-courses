public class TouristService {
    public static void markDuplicates(List<Tourist__c> newTourists) {
        insert newTourists;
        List<Tourist__c> allTourists = TouristManager.getByNameEmailIsDuplicate();
        List<Tourist__c> duplicates = new List<Tourist__c>();
        
        for (Tourist__c firstTourist: allTourists) {
            Integer coincidence = 0;
            
            for (Tourist__c secondTourist: allTourists) {
                
                if (firstTourist.Email__c == secondTourist.Email__c && firstTourist.Name == secondTourist.Name) {
                    coincidence++;
                    
                    if (coincidence > 1 && firstTourist.Id == secondTourist.Id) {
                        secondTourist.IsDuplicate__c = true;
                        duplicates.add(secondTourist);    
                    }
                }
            }
        }
        update duplicates; 
    }
}

/*List<Tourist__c> newTourists= new List<Tourist__c>();
Tourist__c n = new Tourist__c();
n.Name='Barsuk';
n.Birthdate__c = Date.newInstance(2000, 01, 28);
n.Email__c='vyacheslavradyuk@gmail.com';
Tourist__c c = new Tourist__c();
c.Name='Barsuk';
c.Birthdate__c = Date.newInstance(2000, 01, 28);
c.Email__c='vyacheslavradyuk@gmail.com';
newTourists.add(n);
newTourists.add(c);
TouristService.markDuplicates(newTourists);
*/

/*в строчках 32-41 создается 2 экземпляра туриста. далее в 31 создается пустой лист туристов, в 40-41 в этот пустой лист добавляется наш созданный ранее турист.
в 42 строке вызываем наш метод. в 3 строке инсертим наш список добавленных туристов. в 4 строке добавляем в лист всех туристов с нужными нам полями.
создаем лист дубликатов в 10 строке, в 12 строке начинаем первый цикл перебора всего списка туристов, так же добавляем счетчик так как СТАРЫЙ турист из первого и СТАРЫЙ турист второго циклов одного id не должны быть добавлены в дубликаты,
так как это один и тот же турист.  в 15 строке начинаем второй цикл перебора( сравниваем по очереди туриста из первого цикла со всеми туристами в списке). 17 строка если совпадает емейл и имя, то прибавить к счетчику 1
далее ,когда мы отсеяли СТАРЫХ туристов, у нас осталось в 20 строчке проверить айдишники НОВЫХ туристов и если они совпадают добавить в лист дубликатов. Прикладываю файл с общей схемой в комментарии к issue. 
*/