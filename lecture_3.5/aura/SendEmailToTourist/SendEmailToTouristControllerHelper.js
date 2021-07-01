({
    sendEmailHelper: function(component, event, getEmail, getSubject, getBody) {  
        let action = component.get("c.sendMailToTourist");
        action.setParams({
            'mMail': getEmail,
            'mSubject': getSubject,
            'mbody': getBody
        }); 
        $A.get("e.force:closeQuickAction").fire();
        const message = $A.get("$Label.c.sendMessage");
        const duration = 3000;
        const type = $A.get("$Label.c.toastTypeSuccessfully");      
        this.showToast(type, message, duration, event);
        $A.enqueueAction(action);   
    },
    
    showToast : function (type, message, duration, event) {
        let toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({type: type, message: message, duration: duration});
        toastEvent.fire();
    },
})