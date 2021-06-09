({
    fetchTourist : function(component, event) {    
        const action = component.get('c.fetchTourist');
        action.setParams({
            tripRecordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                const responseValue = response.getReturnValue();
                responseValue.forEach(function(value){
                    value.linkName = '/' + value.Id;
                })
                component.set('v.data', responseValue);
            }
        });
        $A.enqueueAction(action);       
    },
    
    createFlights : function(component, event) {
        const action = component.get('c.createFlights');
        action.setParams({
            tripRecordId: component.get('v.recordId'),
            selectedTourists: component.get('v.selectedTourists')
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const responseValue = response.getReturnValue();
                if (responseValue.length > 0) {
                    const toastSuccess = $A.get("e.force:showToast");
                    toastSuccess.setParams({
                        message: $A.get("$Label.c.createFlights"),
                        duration: 3000,
                        type: $A.get("$Label.c.toastTypeSuccessfully")
                    });
                    component.set('v.refreshDataTable', true);
                    component.set('v.refreshDataTable', false);
                    toastSuccess.fire();
                } else {
                    const toastError = $A.get("e.force:showToast");
                    toastError.setParams({
                        message: $A.get("$Label.c.flightCreationErrorNoTouristSelected"),
                        duration: 3000,
                        type: $A.get("$Label.c.toastTypeError")
                    });
                    toastError.fire();
                }
            }  
        });
        $A.enqueueAction(action);
    },
    
    selectRecords : function(component, event) {
        const selectedRows = event.getParam('selectedRows'); 
        let setRows = [];
        
        selectedRows.forEach(function(selectedRow) {
            setRows.push(selectedRow);
        })        
        component.set("v.selectedTourists", setRows);
    },
    
    fetchSeats : function(component, event) {
        const countSeats = component.get('c.getSeatsByTripId');
        countSeats.setParams({
            tripRecordId : component.get('v.recordId')
        });
        countSeats.setCallback(this, function(response){
            const state = response.getState();        
            if (state === "SUCCESS") {
                const value = response.getReturnValue();     
                component.set('v.countSeats', value);
            }
        });
        $A.enqueueAction(countSeats);
    },
    
    fetchFlights : function(component, event) {
        const countFlights = component.get('c.getFlightsByTripId');
        countFlights.setParams({
            tripRecordId : component.get('v.recordId')
        });
        countFlights.setCallback(this, function(response){
            const state = response.getState();           
            if (state === "SUCCESS") {
                const value = response.getReturnValue();
                component.set('v.countFlights', value);
            }
        });
        $A.enqueueAction(countFlights);
    },
    
    fetchStartDate : function(component, event) {
        const startDate = component.get('c.getStartDate');
        startDate.setParams({
            tripRecordId : component.get('v.recordId')
        });
        startDate.setCallback(this, function(response){
            const state = response.getState();           
            if (state === "SUCCESS") {
                const value = response.getReturnValue();
                component.set('v.startDate', value);
            }
        });
        $A.enqueueAction(startDate);
    }
})