trigger geocodeServiceAddress on Venue__c (after insert, after update) {
 for(Venue__c club : Trigger.New)  
 {
     if (club.Address_Geo__Longitude__s == null) {
       GeocodingHelper.forwardGeocodeAddress(club.Id, club.Street_Address__c, club.City_Address__c, club.State_Address__c, club.Zip_Address__c);
     }
 }
}