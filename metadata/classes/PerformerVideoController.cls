public class PerformerVideoController {
    Performer__c performer;
    
    public PerformerVideoController(ApexPages.StandardController stdController) {
        List<String> fields = new String[1];
        fields[0] = 'Youtube_URL__c';
        stdController.addFields(fields);
        
        this.performer = (Performer__c)stdController.getRecord();
    }
    
    public String getYouTubeEmbedLink() {
        return  (performer.Youtube_URL__c != null) 
            ? 'https://www.youtube.com/embed/' + performer.Youtube_URL__c.split('=')[1]
            : 'about:blank';
    }
}