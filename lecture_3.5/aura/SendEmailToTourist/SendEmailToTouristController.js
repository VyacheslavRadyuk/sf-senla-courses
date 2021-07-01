({
    sendEmail : function(component, event, helper) {
        let getRecordId = component.get('v.recordId');
        let getEmail = component.get('v.tourist').Email__c;
        let getSubject = $A.get("$Label.c.subjectEmailToTourist");
        let getBody = $A.get("$Label.c.linkToTheCommunityPageEponec") + getRecordId; 
        helper.sendEmailHelper(component, event, getEmail, getSubject, getBody);   
    }
})