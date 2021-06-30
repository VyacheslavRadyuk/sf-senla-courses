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
                        newTripList.push(value);
                    }                    
                })
                component.set('v.dataTrip', newTripList);                            
            }               
        });
        $A.enqueueAction(action); 
    },
    
    selectRecordsTrip : function(component, event) {
        let selectedItem = event.getParam('currentTarget');
        let index = selectedItem.dataset.record;
        let selectedTripByIndex = component.get("v.dataTrip")[index];
        component.set("v.selectedTrip", selectedTripByIndex);
        component.set("v.isActiveInformationAndButton", false);
        let trip =  component.get('v.selectedTrip');
        component.set('v.mapMarkers', [            
            {
                location: {
                    Latitude: trip.Departure_Space_Point__r.Latitude__c,
                    Longitude: trip.Departure_Space_Point__r.Longitude__c
                }
            }
        ]);
        
        let action = component.get('c.getWeatherForecastBySpacePoint');
        let selectedTrip = component.get('v.selectedTrip');
        action.setParams({            
            selectedTrip: selectedTrip
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
    
    getURLParameterValue: function() {
        var querystring = location.search.substr(1);
        var paramValue = {};
        querystring.split("&").forEach(function(part) {
            var param = part.split("=");
            paramValue[param[0]] = decodeURIComponent(param[1]);
        });
        
        console.log('paramValue-' + paramValue);
        return paramValue;
    }
})