({
    fetchTourists : function(component, event) {    
        let action = component.get('c.fetchTourists');
        action.setParams({
            tripRecordId: component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === 'SUCCESS') {
                let responseValue = response.getReturnValue();
                responseValue.forEach(function(value){
                    value.linkName = '/' + value.Id;
                })
                component.set('v.data', responseValue);
            }
        });
        $A.enqueueAction(action);       
    },
    
    createFlights : function(component, event) {
        let action = component.get('c.createFlights');
        action.setParams({
            tripRecordId: component.get('v.recordId'),
            selectedTourists: component.get('v.selectedTourists')
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let responseValue = response.getReturnValue();
                if (responseValue.length > 0) {
                    const message = $A.get("$Label.c.createFlights");
                    const duration = 3000;
                    const type = $A.get("$Label.c.toastTypeSuccessfully");      
                    this.showToast(type, message, duration, event);
                    component.set('v.isRefreshDataTable', true);
                    component.set('v.isRefreshDataTable', false);
                } else {
                    const message = $A.get("$Label.c.flightCreationErrorNoTouristSelected");
                    const duration = 3000;
                    const type = $A.get("$Label.c.toastTypeError");
                    this.showToast(type, message, duration, event);                  
                }
            }  
        });
        $A.enqueueAction(action);
    },
    
    selectRecords : function(component, event) {
        let selectedRows = event.getParam('selectedRows'); 
        let setRows = [];
        
        selectedRows.forEach(function(selectedRow) {
            setRows.push(selectedRow);
        })        
        component.set("v.selectedTourists", setRows);
    },
    
    fetchSeats : function(component) {
        let countSeats = component.get('c.getSeatsByTripId');
        countSeats.setParams({
            tripRecordId : component.get('v.recordId')
        });
        countSeats.setCallback(this, function(response){
            let state = response.getState();        
            if (state === "SUCCESS") {
                let value = response.getReturnValue();     
                component.set('v.countSeats', value);
            }
        });
        $A.enqueueAction(countSeats);
    },
    
    fetchFlights : function(component) {
        let countFlights = component.get('c.getFlightsByTripId');
        countFlights.setParams({
            tripRecordId : component.get('v.recordId')
        });
        countFlights.setCallback(this, function(response){
            let state = response.getState();           
            if (state === "SUCCESS") {
                let value = response.getReturnValue();
                component.set('v.countFlights', value);
            }
        });
        $A.enqueueAction(countFlights);
    },
    
    fetchStartDate : function(component) {
        let startDate = component.get('c.getStartDate');
        startDate.setParams({
            tripRecordId : component.get('v.recordId')
        });
        startDate.setCallback(this, function(response){
            let state = response.getState();           
            if (state === "SUCCESS") {
                let value = response.getReturnValue();
                component.set('v.startDate', value);
            }
        });
        $A.enqueueAction(startDate);
    },
    
    showToast : function (type, message, duration, event) {
        let toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({type: type, message: message, duration: duration});
        toastEvent.fire();
    },
    
    touristTableBuilding : function(component) {
        component.set("v.columns", [
            {
                "label":"Tourist Name",
                "fieldName":"linkName",
                "type":"url",
                "typeAttributes":{
                    "label":{
                        "fieldName":"Name"
                    },
                    "target":"_blank"
                }
            },
            {
                "label":"Email",
                "fieldName":"Email__c",
                "type":"email",
                "initialWidth":300
            },
            {
                "label":"Gender",
                "fieldName":"Gender__c",
                "type":"picklist",
                "initialWidth":95
            }
        ]
                     );
    }
})