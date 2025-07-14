public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful{
   public Integer recordsProcessed = 0;
   public Database.QueryLocator start(Database.BatchableContext bc){
       return Database.getQueryLocator('SELECT ID, Name, LeadSource FROM Lead');
   }
   public void execute(Database.BatchableContext bc, List<Lead> leadList){
        List<Lead> leads = new List<Lead>();
        for(Lead ld : leadList){
            ld.LeadSource = 'Dreamforce';
            leads.add(ld);
            recordsProcessed = recordsProcessed + 1; 
        }
        update leads;   
    }
    public void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + 'records processed.');
    }        
}