@isTest
public class CountryLayerSchedulerTest {
    @isTest
    static void testScheduleDailyJob() {
 Test.startTest();
        
        HttpResponse mockResponse = new HttpResponse();
        mockResponse.setHeader('Content-Type', 'application/json');
        mockResponse.setBody('[{"name": "Czechia", "alpha2Code": "TC", "alpha3Code": "TST", "capital": "Brno", "region": "Test Region", "regionalBlocs": [{"acronym": "TB"}]}]');
        mockResponse.setStatusCode(200);
        
        Test.setMock(HttpCalloutMock.class, new CountryLayerMock(mockResponse));        
                String jobId = System.schedule('Test Schedule Job', '0 0 0 * * ?', new countryUpdateAPISchedular());

        Test.stopTest();
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