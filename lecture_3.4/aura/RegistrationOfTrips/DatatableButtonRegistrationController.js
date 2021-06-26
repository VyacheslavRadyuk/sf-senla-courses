({
	handleClick : function(component, event, helper) {
        let eventButtonAddToTrip = component.getEvent("eventButtonAddToTrip");
        eventButtonAddToTrip.fire();
    },
    
    doSelectRecord : function(component, event, helper) {
        let eventSelectRecord = component.getEvent("eventSelectRecord");
        eventSelectRecord.setParams({
            "selectedRows" : event.getParam("selectedRows")});
        eventSelectRecord.fire();
    }
})