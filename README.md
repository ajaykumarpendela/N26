# N26 Case Study

Provided here the code for two case studies
* **Case Study 1:**
Once a day, a class implementing the Database.Batchable interface should send out
surveys to customers with a survey_date__c before now. On successful send, the
survey_date__c should be set to null.

* **Case Study 2:**
Display the customer’s product information to the agent whilst they’re interacting.


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
5.Apex batch test class: N26_Contact_Survey_Test

```

**Case study 2**

```
1.Custom fields on Contact: Home_Country__c, Product__c
2.Custom fields on Pricebook Entry: Cost_per_Calendar_Month__c, ATM_Fee_in_other_currencies__c, Card_Replacement_Cost__c
3.Lightning component: N26_ProductInformation
4.Apex Class: N26_ProductInformation
5.Test class: N26_ProductInformation_Test

```


## Running the tests

Run the test classes

**Note:** Used Datafactory (apex class) for creating test classes.

## Built With

* Sublime
* Maven mates
* Git

## Authors

* **Ajay Pendela** - *Initial work* - [AjayKumar](https://github.com/ajaykumarpendela)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Let me know if it require any modifications :+1:
