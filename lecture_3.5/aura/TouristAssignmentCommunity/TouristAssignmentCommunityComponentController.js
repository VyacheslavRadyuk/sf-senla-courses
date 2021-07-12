({
    doInit : function(component,event, helper) {  
        var idParamValue = helper.getURLParameterValue().id;
        component.set('v.selectedTourist', idParamValue);
        component.set('v.isActiveInformationAndButton', true);
        helper.fetchTrips(component, event);
    },  
    
    doSelectRecordTrip : function(component, event, helper) {
        helper.selectRecordsTrip(component, event);
    },
    
    handleClick : function(component, event, helper) {
        let action = component.get('c.createFlightForTouristAssignment');
        let selectedTrip = component.get('v.selectedTrip');
        let selectedTourist = component.get('v.selectedTourist');
        action.setParams({
            selectedTrip: selectedTrip,
            selectedTourist: selectedTourist
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseValue = response.getReturnValue();
                if (responseValue.length != 0) {
                    const errors = action.getError();
                    const message =  $A.get("$Label.c.createFlights");
                    const duration = 3000;
                    const type = $A.get("$Label.c.toastTypeSuccessfully");                      
                    helper.showToast(type, message, duration, event);
                    $A.get('e.force:refreshView').fire();
                } 
            } else if (state === "ERROR") {
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.flightCreationErrorNoTripsSelected");
                const duration = 3000;
                const type = $A.get("$Label.c.toastTypeError");
                helper.showToast(type, errorMsg, duration, event);
            }
        });
        $A.enqueueAction(action);
    }
})