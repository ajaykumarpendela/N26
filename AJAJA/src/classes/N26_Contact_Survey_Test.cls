/*************************************************************
* @Author: Ajay
* @Date: 14/02/2019
* @Name: N26_Contact_Survey_Test
* @Description: Test Class for 'N26_Contact_Survey_Batch'
* @Change History: 
**************************************************************/
@isTest
private class N26_Contact_Survey_Test {
    
    private static TestMethod void ContactSurveyBatch(){
        
        DataFactory dataCreation = new DataFactory();
        Account acc = dataCreation.insertAccount('TestAccount');
         //System.debug('acc'+acc);
        Product2 prod = dataCreation.insertProduct('Standard');
         //System.debug('prod'+prod);
        Pricebook2 pb = dataCreation.insertPricebook('DE');
        // System.debug('pb'+pb);
         
        Contact con1 = dataCreation.insertContact('Test1','TestFirstName','test@test.com', null, acc.Id, prod.Id, 'en', System.today() - 5, pb.Id);
        // System.debug('-->COn'+con1);
        Contact con2 = dataCreation.insertContact('Test2','TestFirstName','test2@test.com', null, acc.Id, prod.Id, 'de', System.today() - 4, pb.Id);
         
        Test.startTest();
           DataBase.executeBatch(new N26_Contact_Survey_Batch()); 
        Test.stopTest();
        Contact con =[SELECT ID, Survey_Date__c FROM Contact Where id =: con1.Id];
        System.assertEquals(null, con.Survey_Date__c);
     }

}