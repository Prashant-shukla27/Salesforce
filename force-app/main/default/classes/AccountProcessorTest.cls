@isTest
public class AccountProcessorTest {

    @isTest
    static void testCountContacts() {
        // Create test accounts
        Account acc1 = new Account(Name = 'Test Account 1');
        Account acc2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{ acc1, acc2 };

        // Create contacts for acc1 only
        List<Contact> contacts = new List<Contact>{
            new Contact(FirstName='John', LastName='Doe', AccountId=acc1.Id),
            new Contact(FirstName='Jane', LastName='Smith', AccountId=acc1.Id)
        };
        insert contacts;

        // Call the @future method
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{ acc1.Id, acc2.Id });
        Test.stopTest(); // Ensures the @future method runs

        // Refresh data
        acc1 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc1.Id];
        acc2 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :acc2.Id];

        // Validate results
        System.assertEquals(2, acc1.Number_Of_Contacts__c);
        System.assertEquals(0, acc2.Number_Of_Contacts__c);
    }
}