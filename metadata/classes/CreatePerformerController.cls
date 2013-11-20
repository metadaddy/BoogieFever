global class CreatePerformerController{
    public String performerName {get; set;}
    public String performerEmail {get; set;}
    ClubEvent__c event;
    
    public CreatePerformerController(ApexPages.StandardController stdController) {
        this.event = (ClubEvent__c)stdController.getRecord();
    }
    
    @RemoteAction
    global static Id insertPerformer(Id eventId, String name, String email) {
        Performer__c p = new Performer__c(
           	Name = name,
            Email__c = email,
            Event__c = eventId
        );
        
        insert p;
        
        return p.Id;
    }
    
    @RemoteAction
    public static Id makeContentPublic(String contentVersionId) {
        ContentVersion cv = [SELECT ContentDocumentId 
                             FROM ContentVersion 
                             WHERE Id = :contentVersionId];
        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = cv.ContentDocumentId, 
            LinkedEntityId = UserInfo.getOrganizationId(), 
            ShareType = 'V');
        insert cdl;
        
        return cv.ContentDocumentId;
    }
}