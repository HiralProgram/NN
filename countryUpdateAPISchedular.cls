public class countryUpdateAPISchedular implements Schedulable , Database.AllowsCallouts {
    public void execute(SchedulableContext ctx) {
        makeCallout();
    }
    @future(callout=true)
    public static void makeCallout(){
                countryUpdateAPIController.callAPI();

    }
   
}