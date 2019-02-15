/****************************************************************
* @Author: Ajay
* @Date: 14/02/2019
* @Name: N26_ProductInformation_Test
* @Description: Test Class for 'N26_ProductInformation' aura class
* @Change History: 
*****************************************************************/
@isTest
private class N26_ProductInformation_Test {
    
    private static TestMethod void ProductInformation(){
        
        DataFactory dataCreation = new DataFactory();
        Account acc = dataCreation.insertAccount('TestAccount');
         //System.debug('acc'+acc);
        Product2 prod = dataCreation.insertProduct('Standard');
         //System.debug('prod'+prod);
        Pricebook2 pb = dataCreation.insertPricebook('DE');
        // System.debug('pb'+pb);
        Contact con1 = dataCreation.insertContact('Test1','TestFirstName','test@test.com', null, acc.Id, prod.Id, 'en', System.today() - 5, pb.Id);
        PricebookEntry pe = dataCreation.insertPricebookEntries_New(prod.Id,pb.Id,'EUR',0,1.7,6);
        Case c = dataCreation.insertCase(con1.Id);
        N26_ProductInformation.getProductData(c.Id);
        
        Product2 prod2 = dataCreation.insertProduct('Black');
        Pricebook2 pb2 = dataCreation.insertPricebook('UK');
        Contact con2 = dataCreation.insertContact('Test2','TestFirstName','test2@test.com', null, acc.Id, prod2.Id, 'de', System.today() - 5, pb2.Id);
        PricebookEntry pe2 = dataCreation.insertPricebookEntries_New(prod2.Id,pb2.Id,'GBP',0,null,6);
        Case c2 = dataCreation.insertCase(con2.Id);
        N26_ProductInformation.getProductData(c2.Id);
    }
}