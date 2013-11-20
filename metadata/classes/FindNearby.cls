global with sharing class FindNearby {

    public FindNearby(ApexPages.StandardSetController controller) { }

    @RemoteAction
    // Find warehouses nearest a geolocation
    global static List<Venue__c> getNearby(String lat, String lon) {

        // If geolocation isn't set, use San Francisco
        if(lat == null || lon == null || lat.equals('') || lon.equals('')) {
            lat = '37.77493';
            lon = '-122.419416';
        }

        // SOQL query to get the nearest warehouses
        String queryString =
            'SELECT Id, Name, Address_Geo__Longitude__s, Address_Geo__Latitude__s, ' +
                'Street_Address__c, Phone__c, City_Address__c ' +
            'FROM Venue__c ' +
            'WHERE DISTANCE(Address_Geo__c, GEOLOCATION('+lat+','+lon+'), \'mi\') < 7 ' +
            'ORDER BY DISTANCE(Address_Geo__c, GEOLOCATION('+lat+','+lon+'), \'mi\') ' +
            'LIMIT 10';

        // Run and return the query results
        return(database.Query(queryString));
    }
}