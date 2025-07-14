public class AddPrimaryContact implements Queueable{
    private Contact con;
    private String state;
    public AddPrimaryContact(Contact con, String state) {
        this.con = con;
        this.state = state;
    }
    public void execute(QueueableContext QC) {
        List<Account> accounts = [Select id,name from Account WHERE BillingState = :state LIMIT 200];
        List<Contact> contacts = new List<Contact>();

        for (Account a: accounts) {
            Contact c = con.clone();
            c.AccountId = a.Id;
            contacts.add(c);
        }

        insert contacts;
    }
}