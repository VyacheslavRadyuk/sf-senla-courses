({
    doInit : function(component, helper) {     
        component.set('v.isNoActiveButton', true);
        component.set("v.isActiveGeolocationOfSpacePoint", false);    
    },  
    
    doSelectRecordTourist : function(component, event, helper) {
        helper.fetchTrip(component, event);
        component.set("v.columnsTrip", [
            {label: 'Trip Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: {fieldName: 'Name'}, target: '_blank'}},
            {label: 'Start date', fieldName: 'Start_Date__c', type: 'date'}
        ]); 
        component.set("v.isActiveGeolocationOfSpacePoint", false);
        component.set("v.isNoActiveButton", true);
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
                } 
            }  
        });
        $A.enqueueAction(action);
        component.set("v.selectedTrip", null);
        component.set("v.selectedTourist", null);    
        component.set('v.isRefreshApp', true);
        component.set('v.isRefreshApp', false);
    }
})