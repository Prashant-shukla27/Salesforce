public class APICallouts {
    public static void callApi(){
        HTTPRequest req = new HTTPRequest();
        req.setEndpoint('https://reqres.in/api/users');
        req.setHeader('Content-Type','application/json');
        req.setMethod('POST');
        req.setBody('{"name" : "Prashant", "job" : "Shukla"}');
        Http httpObj = new Http();
        HTTPResponse res = httpObj.send(req);
        system.debug(res.getBody());
    }
}