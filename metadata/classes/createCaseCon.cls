public with sharing class createCaseCon {

    public blob photo { get; set; }
    public Case theCase {get; set;}
    public String lastError {get; set;}

    public createCaseCon() {
        theCase = new Case();
        lastError = '';
    }
      
    public PageReference save() {
        createNewCase();
        theCase = new Case();
        
        // Clear out view state
        lastError = 'ok';
        photo = null;
 
        return System.currentPageReference();                
        // Continue along
        //return null;
    }
      
     private void createNewCase() {      
        try {
            insert theCase;

           

           
            update theCase;

            FeedItem post = new FeedItem();
            post.ParentId = ApexPages.currentPage().getParameters().get('id');
            post.Body = 'Created a case';
            post.type = 'LinkPost'; 
            post.LinkUrl = '/' + theCase.id;
            post.Title = theCase.Subject;
            insert post;

            } catch(System.Exception ex){
               lastError = ex.getMessage();
            }
        }  
    /*
       
    public PageReference save() {
        c.pathOnClient = '/photos/myphoto';
        Database.insert(c);

        String url = System.currentPageReference().getURL();
        PageReference pr = new PageReference(url + '&saveOkClose=true');
                        
        pr.setRedirect(true);                
        
        return pr;
    }
    */
}