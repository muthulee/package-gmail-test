package wso2.gmail;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.net.http;

public struct UserProfile {
    string emailAddress;
    int messagesTotal;
    int threadsTotal;
    string historyId;
}

public struct Error {
    json errorMessage;
}

@Description {value:"Gmail client connector"}
@Param {value:"userId: The userId of the Gmail account which means the email id"}
@Param {value:"accessToken: The accessToken of the Gmail account to access the gmail REST API"}
@Param {value:"refreshToken: The refreshToken of the Gmail App to access the gmail REST API"}
@Param {value:"clientId: The clientId of the App to access the gmail REST API"}
@Param {value:"clientSecret: The clientSecret of the App to access the gmail REST API"}
public connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                                  string clientSecret) {
    endpoint<oauth2:ClientConnector> gMailEP {
        create oauth2:ClientConnector("https://www.googleapis.com/gmail", accessToken, clientId, clientSecret, refreshToken,
                                      "https://www.googleapis.com", "/oauth2/v3/token");
    }

    http:HttpConnectorError e;
    Error errorResponse = {};

    //string refreshTokenEP = "https://www.googleapis.com";
    //string refreshTokenPath = "/oauth2/v3/token";
    //string baseURL = "https://www.googleapis.com/gmail";

    @Description {value:"Retrieve the user profile information"}
    @Return {value:"response structs"}
    action getUserProfile () (UserProfile, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        UserProfile getUserProfileResponse = {};
        json gMailJSONResponse;
        string getUserProfilePath = "/v1/users/" + userId + "/profile";

        response, e = gMailEP.get(getUserProfilePath, request);
        int statusCode = response.statusCode;
        println("Status code: " + statusCode);
        gMailJSONResponse = response.getJsonPayload();
        if (statusCode == 200) {
            println(gMailJSONResponse.toString());
            getUserProfileResponse, _ = <UserProfile>gMailJSONResponse;
        } else {
            errorResponse.errorMessage = gMailJSONResponse.error;
        }
        return getUserProfileResponse, errorResponse;
    }
}
