/*************************************************************
* @Author: Ajay
* @Date: 14/02/2019
* @Name: DataFactory
* @Description: Class for creating test data for test classes
* @Change History:
**************************************************************/
public class DataFactory {
    
    /*Method Name:insertAccount*/
    public Account insertAccount(String accountName){
        
        Account acc = new Account(Name = accountName);  
        insert acc;
        return acc;
    } 
    
    /* Method Name:insertContacts 
    public List<Contact> insertContacts(integer noofRecords,Id recordTypeId,Id accountId,Id productId, String language, Date surveyDate, Id pricebookID)
    {
        List<Contact> lstcontact=new List<Contact>();
        for(integer i=0;i<noofRecords;i++)
        {
            Contact con=new Contact(LastName ='data'+i,AccountId = accountId, Languages__c ='en', Product__c = productId, survey_date__c = surveyDate, Home_Country__c = pricebookID);
            if(recordTypeId != null)
            {
                con.recordTypeId =recordTypeId;
            }
            lstcontact.add(con);
        }
        
        insert lstcontact;
        return lstcontact;
    } */
    
    /* Method Name:insertContacts */
    public Contact insertContact(String lastName, String firstName, String emailaddress,Id recordTypeId,Id accountId,Id productId, String language, Date surveyDate, Id pricebookID){
        
        List<Contact> lstcontact=new List<Contact>();      
        Contact con=new Contact(LastName =lastName,HasOptedOutOfEmail=FALSE, email= emailaddress, FirstName=firstName, AccountId = accountId, language__c =language, Product__c = productId, survey_date__c = surveyDate, Home_Country__c = pricebookID);
        System.debug('DataFactory'+con);
        if(recordTypeId != null)
        {
            con.recordTypeId =recordTypeId;
        }
        insert con;
        return con;
    } 
    
    /*Method Name:insertProduct*/    
    public Product2 insertProduct(String productName){
        Product2 prod = new Product2(Name = productName, ProductCode = productName, isActive = TRUE);
        insert prod;
        return prod;
    }
    
     /*Method Name:insertPricebook*/ 
    public Pricebook2 insertPricebook(String pricebookName){
        Pricebook2 customPB = new Pricebook2(Name=pricebookName, isActive=true);
        insert customPB;
        return customPB;
    }
    
    /*Method Name:insertPricebookEntries*/ 
    
    public PricebookEntry insertPricebookEntries_New(Id productId, Id pricebookId, String currencyCode, Decimal costPerMonth, Decimal ATMCurrency, Decimal cardRep){
        Id std_PricebookId = Test.getStandardPricebookId();
            
        List<PricebookEntry> pbEntries = new List<PricebookEntry>();
        
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = std_PricebookId, Product2Id = productId, UnitPrice = 1, IsActive = true, CurrencyIsoCode = currencyCode);
        pbEntries.add(standardPrice);
        
        PricebookEntry customPrice = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = productId, UnitPrice = 1, IsActive = true, CurrencyIsoCode = currencyCode, Cost_per_Calendar_Month__c= costPerMonth, ATM_Fee_in_other_currencies__c = ATMCurrency, Card_Replacement_Cost__c = cardRep);
        pbEntries.add(customPrice);
        
        insert pbEntries;
        return customPrice;
    }
    
    /*Method Name:inserCase*/ 
    public Case insertCase(Id contactId){
        Case c = new Case(ContactId=contactId, Status='New', Priority='Low');
        insert c;
        return c;
    }
}