({
    doInit : function(component, event,helper) {
        helper.touristTableBuilding(component);
        helper.fetchTourists(component, event);       
    },
    
    showTripsDatatable : function(component, event, helper) {
        helper.validationTrip(component, event);
    },
    
    handleClick : function (component, event, helper) { 
        component.set("v.showDatatable", false);
        let countSeats = component.get('v.trip').Seats__c;
        let countOccupiedSeats = component.get('v.trip').countOccupiedSeats__c;    
        let startDate = component.get('v.trip').Start_Date__c;
        let todayDate = component.get('v.today');
        let selectedTourists = component.get('v.selectedTourists').length;
        
        if (countOccupiedSeats + selectedTourists > countSeats) {
            const type = $A.get("$Label.c.toastTypeError");
            const message = $A.get("$Label.c.createFlightsError");
            const duration = 3000;
            helper.showToast(type, message, duration, event);
            component.set("v.showDatatable", true);
        } else {
            component.set('v.showConfirmWindow', true);    
        }     
    },
    
    doSelectRecord : function(component, event, helper) {
        helper.selectRecords(component, event);
    },
    
    showSpinner: function(component, helper) {
        component.set("v.isSpinner", true); 
    },
    
    hideSpinner : function(component, helper){  
        component.set("v.isSpinner", false);
    },
    
    confirmDialogNo : function(component, helper) {
        component.set('v.showConfirmWindow', false);
        component.set("v.showDatatable", true);
        component.set("v.selectedTourists", []);
    },
    
    confirmDialogYes : function(component, event, helper) {
        component.set('v.showConfirmWindow', false);
        component.set("v.showDatatable", true);
        helper.createFlights(component, event);
    }
})