({
    doSelectRecordTrip : function(component, event, helper) {
        let eventSelectCardTrip = component.getEvent("eventSelectCardTrip");
        eventSelectCardTrip.setParams({
            "currentTarget" : event.currentTarget});
        eventSelectCardTrip.fire();
    }
})