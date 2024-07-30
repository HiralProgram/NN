trigger trgLeadCountryUpdate on Lead (before insert, before update) {
    Map<String, Country__c> countries = new Map<String, Country__c>();

        for(country__c country: [SELECT name, Capital_city__c,Region__c , Alpha2Code__c, Alpha3Code__c,  RegionalBlocs__c FROM Country__c]){
            countries.put(country.name, country);
        }
		system.debug('Get all keys'+countries.keySet());
    for (Lead lead : Trigger.new) {
        if (lead.Country != null && countries.containsKey(lead.Country)) {
            Country__c country = countries.get(lead.Country);
            if(!String.IsBlank(country.Alpha2Code__c))            
            lead.Alpha2Code__c = country.Alpha2Code__c;
            if(!String.IsBlank(country.Alpha3Code__c))
            lead.Alpha3Code__c = country.Alpha3Code__c;
            if(!String.IsBlank(country.Capital_city__c))
            lead.Capital_city__c = country.Capital_city__c;
            if(!String.IsBlank(country.Region__c))
            lead.Region__c = country.Region__c;
            //lead.RegionalBlocs__c = country.RegionalBlocs__c;
        }
    }
}