public class countryUpdateAPIController {
   // private static final String NAMED_CREDENTIAL = 'CountryLayerAPI';
    private static final String ACCESS_KEY = 'e36077792b163bd80bad3f23a4e51248';
    
    public static void callAPI() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(system.label.country_Layer_API+ '/v2/all?access_key=' + ACCESS_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            List<CountryWrapper> countries = (List<CountryWrapper>) JSON.deserialize(response.getBody(), List<CountryWrapper>.class);
            upsertCountryList(countries);
        } else {
            System.debug('Error: ' + response.getBody());
        }
    }
    
    private static void upsertCountryList(List<CountryWrapper> countries) {
        List<Country__c> countryList = new List<Country__c>();
        for (CountryWrapper country : countries) {
            Country__c singleCountry = new Country__c();
            singleCountry.Name = country.name;
            if(!String.IsBlank(country.alpha2Code))
            singleCountry.Alpha2Code__c = country.alpha2Code;
            if(!String.IsBlank(country.alpha3Code))
            singleCountry.Alpha3Code__c = country.alpha3Code;
            if(!String.IsBlank(country.capital))
            singleCountry.Capital_City__c = country.capital;
            if(!String.IsBlank(country.region))
            singleCountry.Region__c = country.region;
            countryList.add(singleCountry);
        }
        upsert countryList Country__c.Alpha2Code__c;
    }
    
    public class CountryWrapper {
        public String name;
        public String alpha2Code;
        public String alpha3Code;
        public String capital;
        public String region;
       // public List<regionalBlocsWrapper> regionalBlocs;
    }
  /*  public class regionalBlocsWrapper {
        public String acronym;
    }*/
}