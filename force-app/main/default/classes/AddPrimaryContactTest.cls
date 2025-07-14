@isTest
public class AddPrimaryContactTest {

    @isTest
    static void testExecuteMethod() {
        // Create test data
        Account acct1 = new Account(Name = 'Test Account 1',BillingCountry='United States', BillingState = 'California');
        Account acct2 = new Account(Name = 'Test Account 2',BillingCountry='United States', BillingState = 'California');
        insert new List<Account>{acct1, acct2};

        Contact sampleContact = new Contact(FirstName = 'Test', LastName = 'Contact', Email = 'test@example.com');

        // Instantiate the class with test data
        AddPrimaryContact job = new AddPrimaryContact(sampleContact, 'California');

        // Enqueue and execute the job using Test.startTest/Test.stopTest
        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();

        // Assert that 2 new contacts are created and linked to the test accounts
        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'test@example.com'];
        System.assertEquals(2, insertedContacts.size(), 'Expected 2 contacts to be inserted');
        Set<Id> accountIds = new Set<Id>{acct1.Id, acct2.Id};
        for (Contact c : insertedContacts) {
            System.assert(accountIds.contains(c.AccountId), 'Contact should be linked to a valid test account');
        }
    }
}