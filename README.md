# N26 Case Study

Provided here the code for two case studies
* **Case Study 1:**
Once a day, a class implementing the Database.Batchable interface should send out
surveys to customers with a survey_date__c before now. On successful send, the
survey_date__c should be set to null.

* **Case Study 2:**
Display the customer’s product information to the agent whilst they’re interacting.

**Note:** Location - /N26/AJAJA/src

### Prerequisites

* Salesforce

```
Import/Pull the Git Code to Salesforce
```

### Components List

**Case study 1**

```
1.Custom fields on Contact object: survey_date__c, language__c
2.Custom labels: ServiceEmailMessage, ServiceEmailSubject
3.Visualforce template name: ServiceSurveyEmail
4.Apex batch class: N26_Contact_Survey_Batch
5.Apex batch test class: DataFactory, N26_Contact_Survey_Test

```

**Case study 2**

```
1.Custom fields on Contact: Home_Country__c, Product__c
2.Custom fields on Pricebook Entry: Cost_per_Calendar_Month__c, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c
3.Lightning component: N26_ProductInformation
4.Apex Class: N26_ProductInformation
5.Test class: DataFactory, N26_ProductInformation_Test

```

## Deployment

**Pre Deployment Actions:**
- Enable the Translate in Salesforce
- Add German language in Translation

**Deploy listed components into Salesforce** 

**Post Deploymnet Actions**
- Add the Lightning component(B26_ProdutInformation) on Case Layout using Lightning App Builder  

**Run the test senarioes**

## Test

Run the test classes to know the codecoverage
**Note:** Used Datafactory (apex class) for creating test classes.

***Test senario for case study 1:***
* Create a contact populating survey date(before today), email address and language as 'en'
* Repeat the above step with language as 'de'
* Execute the batch class

***Expected Result:*** 
* Batch class will send an email to customers in their languages, first will recive in English, second customer will receive in German
* Check again the contacts records, where survey date should be null


***Test senario for Case study 2:***
* Create a Product as 'Standard', Pricebook as 'DE', 
* Add pricebook entry with EUR currency in standard pricebook
* Add pricebookentry with EUR currecny in custom 'DE' pricebook
* Create a contact by filling Produt__c as 'Standard' product and Home_country__c as 'DE' pricebook
* Create a case by filling above created Contact.

***Expected Result:*** 
* Open create case in Lightning view, you can see ProductInformation lightning card in right side panel, 
* It displays all Cost per month, ATM Fee and Card replacent informaion.

**Note:** Refer word document as attached 

## Built With

* Eclipse
* Maven mates
* Git

## Authors

* **Ajay Pendela** - *Initial work* - [AjayKumar](https://github.com/ajaykumarpendela)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Refer word doc attachment
* Let me know if it require any modifications :+1:
