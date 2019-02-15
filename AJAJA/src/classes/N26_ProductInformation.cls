/*********************************************************************************************
* @Author: Ajay
* @Date: 13/02/2019
* @Name: ProductInformation
* @Description: This class is used for Lightning component - N26_ProductsInformation 
* @Change History: 
**********************************************************************************************/

public class N26_ProductInformation {
    
    //Get all products data information based on case ID
    @AuraEnabled
    public static List<productInfoWrapper> getProductData(Id caseId) {
        //Get Case Contact Product and Home Counrty information
        Case caseInfo = [SELECT ID, Contact.Product__c, Contact.Home_Country__c from Case Where ID = : caseId];   
        //System.debug('-->Case iNfo'+caseInfo);
        //Get all Pricebook entries based on contacts product and home country
        List<PricebookEntry> pricebookEntries= [Select Id,Pricebook2.Name,Product2.Name,Cost_per_Calendar_Month__c,Card_Replacement_Cost__c,ATM_Fee_in_other_currencies__c,CurrencyIsoCode From PricebookEntry Where Product2Id = :caseInfo.Contact.Product__c and Pricebook2id=: caseInfo.Contact.Home_Country__c];
        //System.debug('-->PE list'+pricebookEntries);
        
        // create a wrapper class object and set the wrapper class @AuraEnabled properties and return it to the lightning component.
        //Wrapper is used to set all Pricebookentries data as required
        List<productInfoWrapper> productInformation =  new List<productInfoWrapper>();
        for(PricebookEntry pe:pricebookEntries){
            //System.debug('-->In for lopop of PE'+pe.Cost_per_Calendar_Month__c);
            String currencyCode;
            productInfoWrapper pInfo =  new productInfoWrapper();
            //Set currency based on pricebookentry records
            if(pe.CurrencyIsoCode == 'EUR') currencyCode = '€';
            if(pe.CurrencyIsoCode == 'GBP') currencyCode = '£';
            
            pInfo.productName = pe.Product2.Name; //Set ProductName
            pInfo.homeCountry = pe.Pricebook2.Name; //Set Home COuntry
            pInfo.currencyCode = pe.CurrencyIsoCode; //Set Currency
            //Set cost_per_Calendar_Month 
            if(pe.Cost_per_Calendar_Month__c == null){
            pInfo.cost_per_Calendar_Month = 'N/A'; 
            }else{ pInfo.cost_per_Calendar_Month = currencyCode +' '+ String.valueOf(pe.Cost_per_Calendar_Month__c);}
            //set card_Replacement_Cost
            pInfo.card_Replacement_Cost = currencyCode +' '+ String.valueOf(pe.card_Replacement_Cost__c);
            //set ATM_Fee_in_other_currencies
            if(pe.ATM_Fee_in_other_currencies__c == null){
            pInfo.ATM_Fee_in_other_currencies = 'Free'; 
            }else{ pInfo.ATM_Fee_in_other_currencies = String.valueOf(pe.ATM_Fee_in_other_currencies__c)+'%';}
            //Add all products information 
            productInformation.add(pInfo);
            //System.debug('-->Apex'+pInfo);
        }
        //System.debug('-->Apex final'+productInformation);
    return productInformation;
     }
    
    // wrapper or Inner class with @AuraEnabled {get;set;} properties*
    public class productInfoWrapper{
        @AuraEnabled public String cost_per_Calendar_Month {get;set;}
        @AuraEnabled public String card_Replacement_Cost {get;set;}
        @AuraEnabled public String ATM_Fee_in_other_currencies {get;set;}
        @AuraEnabled public String productName {get;set;}
        @AuraEnabled public String currencyCode {get;set;}
        @AuraEnabled public String homeCountry {get;set;}
    }
}