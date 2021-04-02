/**
 * Created by Ilya Matsuev on 2/28/2021.
 */

public with sharing class RestClientResponse {
    private HttpResponse response { get; set; }

    public Boolean success {
        get {
            return response.getStatusCode() == HttpConstants.SUCCESS_STATUS;
        }
    }

    public RestClientResponse(HttpResponse response) {
        this.response = response;
    }
}
