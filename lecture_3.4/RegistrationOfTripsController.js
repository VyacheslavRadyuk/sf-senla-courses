({
    doInit : function(component, event, helper) {
        component.set("v.columns", [
            {label: 'Tourist Name', fieldName: 'linkName', type: 'url', 
             typeAttributes: {label: {fieldName: 'Name'}, target: '_blank'}},
            {label: 'Email', fieldName: 'Email__c', type: 'email'},
            {label: 'Gender', fieldName: 'Gender__c', type: 'picklist'}
        ]);
        helper.fetchTourist(component, event);
        helper.fetchSeats(component, event);
        helper.fetchFlights(component, event);
        helper.fetchStartDate(component, event);       
        
        const today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        component.set('v.today', today);
    },
    
    handleClick : function (component, event, helper) {               
        const msg = $A.get("$Label.c.confirmationWindow");
        const countSeats = component.get('v.countSeats');
        const countFlights = component.get('v.countFlights');
        const todayDate = component.get('v.today');
        const startDate = component.get('v.startDate');
        const selectedTourists = component.get('v.selectedTourists').length;
        const isValidation = Boolean(countSeats == countFlights || startDate < todayDate);
        const isCheckFreeSeats = Boolean(countFlights + selectedTourists > countSeats);
        
        if (isValidation) {
            component.set('v.isNoActiveButton', true);
        } else if (isCheckFreeSeats) {
            helper.toastErrorNoTouristsSelected(component, event);
        } else if (!confirm(msg)) {
            return false;
        } else {
            helper.createFlights(component, event);          
        }   
    },
    
    doSelectRecord : function(component, event, helper) {
        helper.selectRecords(component, event);
    },
    
    showSpinner: function(component, event, helper) {
        component.set("v.spinner", true); 
    },
    
    hideSpinner : function(component,event,helper){  
        component.set("v.spinner", false);
    }
})