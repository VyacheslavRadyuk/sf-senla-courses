({
    sendEmail : function(component, event, helper) {
        let getRecordId = component.get('v.recordId');
        let getEmail = component.get('v.tourist').Email__c;
        let getSubject = 'Hello, link for travel registration';
        let getBody = 'https://eponec-developer-edition.ap24.force.com/Eponec/s/?id=' + getRecordId; 
        helper.sendEmailHelper(component, event, getEmail, getSubject, getBody);   
    }
})