/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class TestRestrictContactByName {

    @isTest
    static void testValidContactInsert() {
        // This should pass without error
        Contact c = new Contact(FirstName='Jane', LastName='ValidName');
        insert c;
        
        System.assertNotEquals(null, c.Id, 'The valid contact should have been inserted successfully.');
    }

    @isTest
    static void testInvalidContactInsert() {
        // This should trigger the error
        Contact c = new Contact(FirstName='John', LastName='INVALIDNAME');
        
        try {
            insert c;
            System.assert(false, 'Expected an exception due to INVALIDNAME');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'));
        }
    }

    @isTest
    static void testInvalidContactUpdate() {
        // First insert a valid contact
        Contact c = new Contact(FirstName='Jake', LastName='ValidName'); 
        insert c;
        
        // Try to update it to an invalid last name
        c.LastName = 'INVALIDNAME';
        try {
            update c;
            System.assert(false, 'Expected an exception due to INVALIDNAME');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'));
        }
    }
}