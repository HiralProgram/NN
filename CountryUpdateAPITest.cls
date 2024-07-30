@isTest
public class CountryUpdateAPITest {
    
    @isTest
    static void testFetchAndUpdateCountries() {
        
        
        Test.startTest();
        
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('[{"name": "Czechia", "alpha2Code": "TC", "alpha3Code": "TST", "capital": "Brno", "region": "Test Region", "regionalBlocs": [{"acronym": "TB"}]}]');
        mockResponse.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, new CountryLayerMock(mockResponse));
        countryUpdateAPIController.callAPI();
        //countryUpdateAPISchedular.scheduleDailyJob();
         Country__c getCountry = [SELECT Name, Alpha2Code__c, Alpha3Code__c, Capital_City__c, Region__c, RegionalBlocs__c FROM Country__c WHERE Alpha2Code__c = 'TC' LIMIT 1];
        System.assertEquals('Czechia', getCountry.Name);
        System.assertEquals('Brno', getCountry.Capital_City__c);
        Lead lead=new Lead();
        lead.FirstName='Hello';
        lead.LastName='NN';
        lead.Country='Czechia';
        lead.Company='H2 Global';
        insert lead;
        Test.stopTest();
        lead insertedLead=[SELECT name, Capital_city__c,Region__c , Alpha2Code__c, Alpha3Code__c,  RegionalBlocs__c FROM Lead where Id =: lead.id];
       
        
        System.assertEquals('TC', insertedLead.Alpha2Code__c);
        System.assertEquals('TST', insertedLead.Alpha3Code__c);
        System.assertEquals('Brno', insertedLead.Capital_city__c);
        System.assertEquals('Test Region', insertedLead.Region__c);
      //  System.assertEquals(' [{"acronym": "TB"}]', insertedLead.RegionalBlocs__c);
    }
    
    
    public class CountryLayerMock implements HttpCalloutMock {
        private HttpResponse response;
        
        public CountryLayerMock(HttpResponse response) {
            this.response = response;
        }
        
        public HttpResponse respond(HttpRequest req) {
            return response;
        }
        
    }
}