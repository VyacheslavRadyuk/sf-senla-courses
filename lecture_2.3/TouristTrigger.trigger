trigger TouristTrigger on Tourist__c (after insert, after update) {
    switch on Trigger.operationtype {
        when AFTER_INSERT {
            AsynchTouristService.markDuplicates(Trigger.newMap.keyset()); 
        }
        when AFTER_UPDATE {
            TouristTriggerHandler.afterUpdate(Trigger.new);   
        }
    }
}