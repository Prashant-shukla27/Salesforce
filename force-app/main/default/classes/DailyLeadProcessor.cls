public  class DailyLeadProcessor implements Schedulable{
    
    public void execute(SchedulableContext ctx){
        List<Lead> lList = [Select Leadsource , status from lead where leadsource = null LIMIT 200];
        
        List<Lead> updatedList = new List<Lead>();
        For(Lead l: lList){
            l.leadsource = 'Dreamforce';
            updatedList.add(l);
        }
        update updatedList;
    }
}