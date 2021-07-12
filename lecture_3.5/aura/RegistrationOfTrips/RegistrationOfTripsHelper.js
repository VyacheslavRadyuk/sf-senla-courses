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
            } else if (state == 'ERROR') {
                const errors = action.getError();
                const errorMsg = (errors.length) ? errors[0].message : $A.get("$Label.c.assignScreenErrorMissingTripId");
                const duration = 3000;
                const type = $A.get("$Label.c.toastTypeError");
                this.showToast(type, errorMsg, duration, event);
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
                const message = $A.get("$Label.c.createFlights");
                const duration = 3000;
                const type = $A.get("$Label.c.toastTypeSuccessfully");      
                this.showToast(type, message, duration, event);
                component.set("v.selectedTourists", []);
                $A.get('e.force:refreshView').fire();                    
            } else if (state == 'ERROR') {
                const errors = action.getError();
                const message = (errors.length) ? errors[0].message : $A.get("$Label.c.flightCreationErrorNoTouristSelected");
                const duration = 3000;
                const type = $A.get("$Label.c.toastTypeError");
                this.showToast(type, message, duration, event);                 
            }  
        });
        $A.enqueueAction(action);
        component.find('tripRecordId').reloadRecord(true);
        component.set("v.showDatatable", false);
    },
    
    selectRecords : function(component, event) {
        let selectedRows = event.getParam('selectedRows'); 
        let setRows = [];
        
        selectedRows.forEach(function(selectedRow) {
            setRows.push(selectedRow);
        })        
        component.set("v.selectedTourists", setRows);
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
    },
    
    validationTrip : function(component, event) {
        let countFreeSeats = component.get("v.trip").Seats__c - component.get("v.trip").countOccupiedSeats__c;      
        let today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        if (countFreeSeats > 0 && component.get("v.trip").Start_Date__c > today) {
            component.set("v.showDatatable", true);
            component.set('v.today', today);
        }
    }
})