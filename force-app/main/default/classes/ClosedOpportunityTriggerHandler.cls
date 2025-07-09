public class ClosedOpportunityTriggerHandler {
    public static void closedOpportunities(List<Opportunity> oppList){
        List<Task> taskList = new List<Task>();
        for(Opportunity opp : oppList) {
            if(opp != null && opp.stageName == 'Closed Won'){
                Task newTask = new Task(Subject = 'Follow Up Test Task' , WhatId = opp.Id);
                taskList.add(newTask);
            }
        }
        system.debug('TaskList ' + taskList);
        Database.insert(taskList);
    }
}