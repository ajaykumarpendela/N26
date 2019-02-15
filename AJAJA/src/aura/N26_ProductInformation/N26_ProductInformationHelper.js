({
	getProductInfo : function(component) {
        //Call apex controler method
        var action = component.get("c.getProductData");
		action.setParams({
   			 caseId:component.get('v.recordId') // set parameters for controler method
		});
        
        //set callback funtion
		action.setCallback(this, function(data) {
            console.log('--->'+JSON.stringify(data.getReturnValue()));
            component.set('v.wrapperList',data.getReturnValue()); //Pass the data to wrapperList attribute
		});
		$A.enqueueAction(action);	 //enqueue Action	
	}
})