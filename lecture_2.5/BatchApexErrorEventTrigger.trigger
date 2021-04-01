trigger BatchApexErrorEventTrigger on BatchApexErrorEvent (after insert) {
    switch on Trigger.operationtype {
        when AFTER_INSERT {
            BatchApexErrorEventTriggerHandler.logErrors(Trigger.new); 
        }
    }
}