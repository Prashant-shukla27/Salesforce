public without sharing class AccountAddressTriggerHandler {
    public static void matchBillingAddress(List<Account> accList){
        for(Account acc : accList){
            if(acc != null && acc.Match_Billing_Address__c != null && acc.Match_Billing_Address__c){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
}