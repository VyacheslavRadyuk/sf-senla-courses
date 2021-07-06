({
    doInit : function(component,event, helper) {  
        var idParamValue = helper.getURLParameterValue().id;
        component.set('v.selectedTourist', idParamValue);
        component.set('v.isActiveInformationAndButton', true);
        helper.fetchTrip(component, event);
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