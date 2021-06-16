({
    fetchTrip : function(component) {    
        const action = component.get('c.getTrips');
        const selectedTourist = component.get('v.selectedTourist');
        action.setParams({            
            selectedTourist: selectedTourist
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                const responseValue = response.getReturnValue();
                responseValue.forEach(function(value){
                    value.linkName = '/' + value.Id;
                })
                component.set('v.dataTrip', responseValue);                            
            }               
        });
        $A.enqueueAction(action); 
    },
    
    selectRecordsTrip : function(component, event) {
        const selectedRows = event.getParam('selectedRows'); 
        let setRows = [];
        
        selectedRows.forEach(function(selectedRow) {
            setRows.push(selectedRow);
        })        
        component.set("v.selectedTrip", setRows);
        component.set("v.isNoActiveButton", false);
        const trip =  component.get('v.selectedTrip');       
        component.set('v.mapMarkers', [            
            {
                location: {
                    Latitude: trip[0].Departure_Space_Point__r.Latitude__c,
                    Longitude: trip[0].Departure_Space_Point__r.Longitude__c
                }
            }
        ]);
        component.set("v.isActiveGeolocationOfSpacePoint", true);
        
        const action = component.get('c.getWeatherForecastBySpacePoint');
        const selectedTrip = component.get('v.selectedTrip');
        action.setParams({            
            selectedTrip: selectedTrip[0]
        });
        action.setCallback(this, function(response) {
            const state = response.getState();
            if (state === 'SUCCESS') {
                const responseValue = response.getReturnValue();
                component.set("v.date", responseValue.Date__c); 
                component.set("v.averageTemperature", responseValue.Average_Temperature__c);           
            }               
        });   
        $A.enqueueAction(action); 
    },
    
    fetchFlights : function(component, event) {
        const action = component.get('c.getFlightsBySelectedTrip');
        const selectedTrip = component.get('v.selectedTrip');
        action.setParams({            
            selectedTrip: selectedTrip[0]
        });
        action.setCallback(this, function(response) {
            const state = response.getState();   
            if (state === 'SUCCESS') {
                const responseValue = response.getReturnValue();
                component.set("v.countOccupiedSeats", responseValue.length);          
            }               
        });   
        $A.enqueueAction(action); 
    }
})