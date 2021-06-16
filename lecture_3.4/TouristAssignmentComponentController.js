({
    doInit : function(component, event, helper) {
        component.set("v.columnsTourist", [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: {fieldName: 'Name'}, target: '_blank'}},
            {label: 'Email', fieldName: 'Email__c', type: 'email'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'picklist'}
        ]); 
        component.set('v.isNoActiveButton', true);
        helper.fetchTourist(component, event);
        component.set("v.isActiveGeolocationOfSpacePoint", false);    
    },  
    
    doSelectRecordTourist : function(component, event, helper) {
        helper.selectRecordsTourist(component, event);
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
        helper.fetchFlights(component, event);
    },
    
    handleClick : function(component, event, helper) {
        const action = component.get('c.createFlightForTouristAssignment');
        const selectedTrip = component.get('v.selectedTrip');
        const selectedTourist = component.get('v.selectedTourist');
        action.setParams({
            selectedTrip: selectedTrip[0],
            selectedTourist: selectedTourist[0]
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
        component.set('v.isRefreshApp', true);
        component.set('v.isRefreshApp', false);        
    }
})