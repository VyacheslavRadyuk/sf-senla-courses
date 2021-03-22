trigger TouristTrigger on Tourist__c (before insert, after update) {
    switch on Trigger.operationtype {
        when BEFORE_INSERT {
            TouristService.markDuplicates(Trigger.new); 
        }
        when AFTER_UPDATE {
            TouristTriggerHandler.afterUpdate(Trigger.new);   
        }
    }
}