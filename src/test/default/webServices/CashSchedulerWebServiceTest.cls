/**
 * Created by Ilya Matsuev on 4/3/2021.
 */

@IsTest(IsParallel=true)
private class CashSchedulerWebServiceTest {

    private static final TestDataFactory dataFactory = new TestDataFactory();

    private static final Integer CONTACT_CASH_SCHEDULER_ID_1 = 1;
    private static final Integer CONTACT_CASH_SCHEDULER_ID_2 = 2;
    private static final Integer CONTACT_CASH_SCHEDULER_ID_3 = 3;


    @TestSetup
    private static void setup() {
        Account cashSchedulerAccount = dataFactory.generateCashSchedulerAccount();
        insert cashSchedulerAccount;

        List<Contact> contacts = new List<Contact> {
                dataFactory.generateContact(
                        cashSchedulerAccount.Id,
                        CONTACT_CASH_SCHEDULER_ID_1,
                        'Joe',
                        'Biden',
                        'joe.biden@gmail.com'
                ),
                dataFactory.generateContact(
                        cashSchedulerAccount.Id,
                        CONTACT_CASH_SCHEDULER_ID_2,
                        'Jim',
                        'Carry',
                        'jim.carry@gmail.com'
                ),
                dataFactory.generateContact(
                        cashSchedulerAccount.Id,
                        CONTACT_CASH_SCHEDULER_ID_3,
                        'John',
                        'Watson',
                        'john.watson@gmail.com'
                )
        };
        insert contacts;
    }

    @IsTest
    public static void httpDeletePositiveTest() {
        RestRequest request = new RestRequest();
        RestResponse response = new RestResponse();
        request.requestURI = Url.getSalesforceBaseUrl().toExternalForm()
                + '/services/apexrest/CashSchedulerWebService/';
        request.httpMethod = 'DELETE';
        request.params.putAll(new Map<String, String> {
                'sobjecttypename' => Contact.class.getName(),
                'ids' => CONTACT_CASH_SCHEDULER_ID_1 + ',' + CONTACT_CASH_SCHEDULER_ID_2
        });
        // NOTE: no sense to specify authorization header
        response.statusCode = HttpConstants.SUCCESS_STATUS;


        Test.startTest();
        RestContext.request = request;
        RestContext.response = response;
        CashSchedulerWebService.DeleteRecords();
        Test.stopTest();


        List<Contact> contacts = getContacts();
        Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(
                response.responseBody.toString()
        );

        System.assertEquals(1, contacts.size());
        System.assertEquals(CONTACT_CASH_SCHEDULER_ID_3, contacts.get(0).CashSchedulerId__c);
        System.assert(response.headers.containsKey(HttpConstants.CONTENT_TYPE_HEADER));
        System.assertEquals(HttpConstants.CONTENT_TYPE_JSON, response.headers.get(HttpConstants.CONTENT_TYPE_HEADER));
        System.assert(responseBody.containsKey('success'));
        System.assert(responseBody.containsKey('errors'));
        System.assert((Boolean) responseBody.get('success'));
        System.assert(((List<Object>) responseBody.get('errors')).isEmpty());
        System.assertEquals(HttpConstants.SUCCESS_STATUS, response.statusCode);
    }


    private static List<Contact> getContacts() {
        return [
                SELECT CashSchedulerId__c
                FROM Contact
        ];
    }
}
