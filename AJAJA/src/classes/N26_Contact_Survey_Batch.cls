/*********************************************************************************************
* @Author: Ajay
* @Date: 13/02/2019
* @Name: N26_Contact_Survey_Batch
* @Description: Send a survey email link to all Contacts based on survey date is before today. 
                On sucessful send, the survey date sets to null
* @Change History: 
**********************************************************************************************/
global class N26_Contact_Survey_Batch implements Database.Batchable<sObject> {
    List<Contact> successContacts = new List<Contact>();
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        // Query records with criteria Survey date should be less than today and Email field should not be null 
        return Database.getQueryLocator('SELECT ID, FirstName, language__c, Survey_Date__c FROM Contact Where Survey_Date__c<TODAY AND HasOptedOutOfEmail=FALSE AND Email!=NULL');
    }
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        // process each batch of records
        // Get Id of Visualforce template
        Id templateId =  [select id, name from EmailTemplate where developername = 'ServiceSurveyEmail'].id; 
        Set<ID> processedRecords = new Set<ID>();
        //Initialize singleEmialMessage
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        //Bulkify code to send all emails at once
        for(Contact con:scope){
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage(); //Create single email message for each contact
            email.setTargetObjectId(con.Id);  //set Target object Id as Contact ID
            email.setTemplateId(templateId); //set Template ID
            emails.add(email); // Add single email to List os emails
            processedRecords.add(con.id); // Used to remove the errored out contacts after sending email
        }
        //Check size of emails before sending, enter only if size is not empty
        if(emails != null && emails.size()>0){
               // Send all emails, SendEmailResult will store all resulted information.
               List<Messaging.SendEmailResult> results=  Messaging.sendEmail(emails); 
               //Check for errored out records
               for(Integer i=0;i<results.size();i++){
                   if (!results.get(i).isSuccess()) {
                       processedRecords.remove(results.get(i).getErrors()[i].getTargetObjectId()); //Remove errored out records
                    }
                }  
               //Make Survey date as null for sucessfuly processed records
               List<Contact> finalContacts = new List<Contact>();
                for(Id con:processedRecords){
                   Contact c = new Contact();
                        c.Id = con;
                        c.survey_date__c = NULL;
                        finalContacts.add(c);
                }
            //Pre check size before update contact
            if(finalContacts != null && finalContacts.size()>0)
                Update finalContacts;
        }
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }    
}