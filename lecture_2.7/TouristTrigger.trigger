trigger TouristTrigger on Tourist__c (after insert, after update) {
    switch on Trigger.operationtype {
        when AFTER_INSERT {
            TouristTriggerHandler.onAfterInsert(Trigger.newMap.keyset()); 
        }
        when AFTER_UPDATE {
            TouristTriggerHandler.afterUpdate(Trigger.oldMap, Trigger.new);   
        }
    }
}