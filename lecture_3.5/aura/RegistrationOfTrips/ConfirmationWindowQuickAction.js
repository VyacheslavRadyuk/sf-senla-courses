({
    confirmDialogNo : function(component, event, helper) {
        let eventButtonNo = component.getEvent("eventButtonNo");
        eventButtonNo.fire();
    },
    
    confirmDialogYes : function(component, event, helper) {
        let eventButtonYes = component.getEvent("eventButtonYes");
        eventButtonYes.fire();
    }
})