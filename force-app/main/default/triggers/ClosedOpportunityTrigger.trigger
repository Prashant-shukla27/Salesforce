trigger ClosedOpportunityTrigger on Opportunity (after insert , after update) {
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        ClosedOpportunityTriggerHandler.closedOpportunities(Trigger.new);
    }
}