@isTest
private class LeadProcessorTest {

    @isTest
    static void testLeadProcessor() {
        // 1. Prepare Test Data
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) { // Create more than 200 leads to test batching
            testLeads.add(new Lead(
                FirstName = 'Test',
                LastName = 'Lead' + i,
                Company = 'Test Company ' + i,
                LeadSource = 'Web' // Initial LeadSource
            ));
        }
        insert testLeads;

        // Verify initial state (optional but good practice)
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Web'], 'Expected 200 leads with LeadSource "Web" initially.');

        // 2. Execute the Batch Class
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp);
        Test.stopTest();
     
        // Verify that no leads still have the old LeadSource
        System.assertEquals(0, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Web'], 'Expected no leads with LeadSource "Web" after processing.');
        System.assertEquals(200, [SELECT COUNT() FROM Lead WHERE LeadSource = 'Dreamforce'], 'Expected 200 leads with LeadSource "Dreamforce" after processing.');
    }

    @isTest
    static void testLeadProcessorWithNoData() {
        // Test case where no leads exist
        Integer initialLeadCount = [SELECT COUNT() FROM Lead];
        System.assertEquals(0, initialLeadCount, 'Expected no leads in the database initially for this test.');

        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Database.executeBatch(lp);
        Test.stopTest();

        // Assert that no records were processed and no errors occurred
        System.assertEquals(0, lp.recordsProcessed, 'Expected 0 records processed when no leads exist.');
        System.assertEquals(0, [SELECT COUNT() FROM Lead], 'Expected no leads to be created or modified.');
    }
}