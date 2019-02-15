({
	initAction : function(component, event, helper) {
        console.log('-->ReocrdId'+component.get('v.recordId'));
        //Call the helper method
        helper.getProductInfo(component);
	}
})