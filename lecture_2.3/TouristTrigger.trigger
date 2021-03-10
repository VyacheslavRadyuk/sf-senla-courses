trigger TouristTrigger on Tourist__c (after insert, after update) {
    switch on Trigger.operationtype {
        when AFTER_INSERT {
            TouristTriggerHandler.afterInsert(Trigger.new); 
        }
        when AFTER_UPDATE {
            TouristTriggerHandler.afterUpdate(Trigger.new);   
        }
    }
}