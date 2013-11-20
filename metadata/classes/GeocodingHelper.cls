//forward geocoding using google
global class GeocodingHelper
{
  @future (callout=true)
  public static void forwardGeocodeAddress(Id vId, String street, String state, String city, String zip) {     
      String encodedAddress  = GeocodingHelper.encodeAddress(street,state,city,zip);
      
      HttpRequest req = new HttpRequest();
      req.setEndpoint('http://maps.googleapis.com/maps/api/geocode/json?address='+encodedAddress+'&sensor=true');
      req.setMethod('GET');
      
      
      Http http = new Http();
      HTTPResponse res = http.send(req);
      System.debug(res.getBody()); 
      
     
      JSONParser parser = JSON.createParser(res.getBody());
      
      //Moscone West, SF
      Double lng = -122.4033372;
      Double lat = 37.7829932; 
      
      while(parser.nextToken() != null)
      {
       if(parser.getText() == 'lat')
       {    parser.nextValue();
            lat = parser.getDoubleValue();
       }
       if(parser.getText() == 'lng')
       {
            parser.nextValue();
            lng = parser.getDoubleValue();
       }
      }
      
      
      
      Venue__c club = [select id, name, Address_Geo__Latitude__s, Address_Geo__Longitude__s from Venue__c where id =:vId];
      club.Address_Geo__Latitude__s = lat;
      club.Address_Geo__Longitude__s = lng;
      update club;
  }
    
   public static String encodeAddress(String street, String city, String state, String zip)
   {
       return EncodingUtil.urlEncode(street+','+city+','+state+','+zip, 'UTF-8');
   }
}