({
    fetchTrip : function(component) {    
        let action = component.get('c.getTrips'); 
        let selectedTourist = component.get('v.selectedTourist');
        let newTripList = [];
        action.setParams({            
            selectedTourist: selectedTourist
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === 'SUCCESS') {
                let responseValue = response.getReturnValue();
                responseValue.forEach(function(value){
                    if(value.Seats__c > value.countOccupiedSeats__c) {     
                        value.linkName = '/' + value.Id;
                        newTripList.push(value);
                    }                    
                })
                component.set('v.dataTrip', newTripList);                            
            }               
        });
        $A.enqueueAction(action); 
    },
    
    selectRecordsTrip : function(component, event) {
        let selectedRows = event.getParam('selectedRows'); 
        let setRows = [];
        
        selectedRows.forEach(function(selectedRow) {
            setRows.push(selectedRow);
        })        
        component.set("v.selectedTrip", setRows);
        component.set("v.isNoActiveButton", false);
        let trip =  component.get('v.selectedTrip');       
        component.set('v.mapMarkers', [            
            {
                location: {
                    Latitude: trip[0].Departure_Space_Point__r.Latitude__c,
                    Longitude: trip[0].Departure_Space_Point__r.Longitude__c
                }
            }
        ]);
        component.set("v.isActiveGeolocationOfSpacePoint", true);
        
        let action = component.get('c.getWeatherForecastBySpacePoint');
        let selectedTrip = component.get('v.selectedTrip');
        action.setParams({            
            selectedTrip: selectedTrip[0]
        });
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === 'SUCCESS') {
                let responseValue = response.getReturnValue();
                component.set("v.date", responseValue.Date__c); 
                component.set("v.averageTemperature", responseValue.Average_Temperature__c);           
            }               
        });   
        $A.enqueueAction(action); 
    },
  
    tripTableBuilding : function(component) {    
        component.set("v.columnsTrip", [
            {
                label: 'Trip Name', 
                fieldName: 'linkName', 
                type: 'url', 
                typeAttributes: {
                    label: {
                        fieldName: 'Name'
                    }, 
                    target: '_blank'
                }
            },
            {
                label: 'Start date', 
                fieldName: 'Start_Date__c', 
                type: 'date'
            }
        ]
                     );
    }
})