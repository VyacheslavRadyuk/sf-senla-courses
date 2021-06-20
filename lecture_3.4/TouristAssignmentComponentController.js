({
    doInit : function(component, helper) {     
        component.set('v.isNoActiveButton', true);
        component.set("v.isActiveGeolocationOfSpacePoint", false);    
    },  
    
    doSelectRecordTourist : function(component, event, helper) {
        helper.fetchTrip(component, event);
        helper.tripTableBuilding(component);
        component.set("v.isActiveGeolocationOfSpacePoint", false);
        component.set("v.isNoActiveButton", true);
        component.set("v.selectedTrip", null);
    },
    
    doSelectRecordTrip : function(component, event, helper) {
        helper.selectRecordsTrip(component, event);
        helper.fetchFlights(component);
    },
    
    handleClick : function(component, event, helper) {
        const action = component.get('c.createFlightForTouristAssignment');
        const selectedTrip = component.get('v.selectedTrip');
        const selectedTourist = component.get('v.selectedTourist');
        action.setParams({
            selectedTrip: selectedTrip[0],
            selectedTourist: selectedTourist
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const responseValue = response.getReturnValue();
                if (responseValue.length != 0) {
                    const toastSuccess = $A.get("e.force:showToast");
                    toastSuccess.setParams({
                        message: $A.get("$Label.c.createFlights"),
                        duration: 3000,
                        type: $A.get("$Label.c.toastTypeSuccessfully")
                    });
                    toastSuccess.fire();
                    $A.get('e.force:refreshView').fire();
                } 
            }  
        });
        $A.enqueueAction(action);       
    }
})