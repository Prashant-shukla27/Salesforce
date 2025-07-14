public class AccountProcessor {

    @future
    public static void countContacts(List<Id> accountIds) {
        // Query to count contacts grouped by AccountId
        List<AggregateResult> groupedResults = [
            SELECT AccountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ];

        // Map to hold AccountId => Contact Count
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        for (AggregateResult ar : groupedResults) {
            Id accountId = (Id) ar.get('AccountId');
            Integer count = (Integer) ar.get('contactCount');
            contactCountMap.put(accountId, count);
        }

        // Query the accounts to update
        List<Account> accountsToUpdate = [SELECT Id, Number_Of_Contacts__c FROM Account WHERE Id IN :accountIds];

        for (Account acc : accountsToUpdate) {
            acc.Number_Of_Contacts__c = contactCountMap.containsKey(acc.Id) ? contactCountMap.get(acc.Id) : 0;
        }

        // Perform the update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}