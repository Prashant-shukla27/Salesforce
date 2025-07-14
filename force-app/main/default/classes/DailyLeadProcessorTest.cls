@isTest
public class DailyLeadProcessorTest {

    @isTest
    static void testExecute() {
        // Create test leads with leadsource = null
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 5; i++) {
            leads.add(new Lead(LastName = 'Test' + i, Company = 'TestCompany', LeadSource = null, Status = 'Open - Not Contacted'));
        }
        insert leads;

        // Verify leads inserted with LeadSource = null
        List<Lead> insertedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id IN :leads];
        for (Lead l : insertedLeads) {
            System.assertEquals(null, l.LeadSource);
        }

        // Instantiate the scheduled class and execute
        Test.startTest();
        // Schedule the job to run immediately
        String sch = '0 0 0 1 1 ? 2099'; // Runs once in the future (just a dummy schedule)
        String jobId = System.schedule('TestDailyLeadProcessorJob', sch, new DailyLeadProcessor());
        Test.stopTest();

        // Verify the leads are updated to 'Dreamforce'
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead WHERE Id IN :leads];
        for (Lead l : updatedLeads) {
            System.assertEquals('Dreamforce', l.LeadSource);
        }
    }
}