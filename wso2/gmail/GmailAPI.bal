package wso2.gmail;

import org.wso2.ballerina.connectors.oauth2;
import ballerina.net.http;
import ballerina.util;

public struct UserProfile {
    string emailAddress;
    int messagesTotal;
    int threadsTotal;
    string historyId;
}

public struct Message {
    string to;
    string subject;
    string from;
    string messageBody;
    string cc;
    string bcc;
    string id;
    string threadId;
}

public struct Header {
    string name;
    string value;
}

public struct Parts {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
}

public struct Body {
    string attachmentId;
    int size;
    string data;
}

public struct MessagePayload {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
    Parts[] parts;
}

public struct GmailAPI {
    string id;
    string threadId;
    string[] labelIds;
    string snippet;
    string historyId;
    string internalDate;
    MessagePayload payload;
    int sizeEstimate;
}

public struct Draft {
    string id;
    GmailAPI mailMessage;
}

public struct Drafts {
    Draft[] drafts;
    int resultSizeEstimate;
    string nextPageToken;
}

public struct DraftsListFilter {
    string includeSpamTrash;
    string maxResults;
    string pageToken;
    string q;
}

public struct Error {
    json errorMessage;
}

public struct StatusCode {
    int statusCode;
}

@Description {value:"Gmail client connector"}
@Param {value:"userId: The userId of the Gmail account which means the email id"}
@Param {value:"accessToken: The accessToken of the Gmail account to access the gmail REST API"}
@Param {value:"refreshToken: The refreshToken of the Gmail App to access the gmail REST API"}
@Param {value:"clientId: The clientId of the App to access the gmail REST API"}
@Param {value:"clientSecret: The clientSecret of the App to access the gmail REST API"}
public connector ClientConnector (string userId, string accessToken, string refreshToken, string clientId,
                                  string clientSecret) {
    endpoint<oauth2:ClientConnector> gmailEP {
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
        string getUserProfilePath = "/v1/users/" + userId + "/profile";

        response, e = gmailEP.get(getUserProfilePath, request);
        int statusCode = response.statusCode;
        println("Status code: " + statusCode);
        json gmailJSONResponse = response.getJsonPayload();

        if (statusCode == 200) {
            println(gmailJSONResponse.toString());
            getUserProfileResponse, _ = <UserProfile>gmailJSONResponse;
        } else {
            errorResponse.errorMessage = gmailJSONResponse.error;
        }
        return getUserProfileResponse, errorResponse;
    }

    @Description {value:"Send a mail"}
    @Param {value:"sendMail: It is a struct. Which contains all optional parameters (to,subject,from,messageBody,
    cc,bcc,id,threadId)"}
    @Return {value:"response struct"}
    action sendMail (Message sendMail) (GmailAPI, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        GmailAPI sendMailResponse = {};
        string concatRequest = "";

        if (sendMail != null) {
            string to = sendMail.to;
            string subject = sendMail.subject;
            string from = sendMail.from;
            string messageBody = sendMail.messageBody;
            string cc = sendMail.cc;
            string bcc = sendMail.bcc;
            string id = sendMail.id;
            string threadId = sendMail.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = util:base64Encode(concatRequest);
        json sendMailJSONRequest = {"raw":encodedRequest};
        string sendMailPath = "/v1/users/" + userId + "/messages/send";
        request.setHeader("Content-Type", "Application/json");
        request.setJsonPayload(sendMailJSONRequest);
        response, e = gmailEP.post(sendMailPath, request);
        int statusCode = response.statusCode;
        println("Status code: " + statusCode);
        json sendMailJSONResponse = response.getJsonPayload();

        if (statusCode == 200) {
            println(sendMailJSONResponse.toString());
            sendMailResponse, _ = <GmailAPI>sendMailJSONResponse;
        } else {
            errorResponse.errorMessage = sendMailJSONResponse.error;
        }
        return sendMailResponse, errorResponse;
    }

    @Description {value:"Create a draft"}
    @Param {value:"createDraft: It is a struct. Which contains all optional parameters (to,subject,from,messageBody
    ,cc,bcc,id,threadId) to create draft message"}
    @Return {value:"response structs"}
    action createDraft (Message createDraft) (Draft, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        Draft createDraftResponse = {};
        string concatRequest = "";

        if (createDraft != null) {
            string to = createDraft.to;
            string subject = createDraft.subject;
            string from = createDraft.from;
            string messageBody = createDraft.messageBody;
            string cc = createDraft.cc;
            string bcc = createDraft.bcc;
            string id = createDraft.id;
            string threadId = createDraft.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = util:base64Encode(concatRequest);
        json createDraftJSONRequest = {"message":{"raw":encodedRequest}};
        string createDraftPath = "/v1/users/" + userId + "/drafts";
        request.setHeader("Content-Type", "Application/json");
        request.setJsonPayload(createDraftJSONRequest);
        response, e = gmailEP.post(createDraftPath, request);
        int statusCode = response.statusCode;
        println("Status code: " + statusCode);
        json createDraftJSONResponse = response.getJsonPayload();

        if (statusCode == 200) {
            println(createDraftJSONResponse.toString());
            createDraftResponse, _ = <Draft>createDraftJSONResponse;
        } else {
            errorResponse.errorMessage = createDraftJSONResponse.error;
        }
        return createDraftResponse, errorResponse;
    }

    @Description {value:"Update a draft"}
    @Param {value:"draftId: Id of the draft to update"}
    @Param {value:"update: It is a struct. Which contains all optional parameters (to,subject,from,messageBody
    ,cc,bcc,id,threadId) to update draft"}
    @Return {value:"response structs"}
    action update (string draftId, Message update) (Draft, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        Draft updateResponse = {};
        string concatRequest;

        if (update != null) {
            string to = update.to;
            string subject = update.subject;
            string from = update.from;
            string messageBody = update.messageBody;
            string cc = update.cc;
            string bcc = update.bcc;
            string id = update.id;
            string threadId = update.threadId;

            if (to != "") {
                concatRequest = concatRequest + "to:" + to + "\n";
            }
            if (subject != "") {
                concatRequest = concatRequest + "subject:" + subject + "\n";
            }
            if (from != "") {
                concatRequest = concatRequest + "from:" + from + "\n";
            }
            if (cc != "") {
                concatRequest = concatRequest + "cc:" + cc + "\n";
            }
            if (bcc != "") {
                concatRequest = concatRequest + "bcc:" + bcc + "\n";
            }
            if (id != "") {
                concatRequest = concatRequest + "id:" + id + "\n";
            }
            if (threadId != "") {
                concatRequest = concatRequest + "threadId:" + threadId + "\n";
            }
            if (messageBody != "") {
                concatRequest = concatRequest + "\n" + messageBody + "\n";
            }
        }
        string encodedRequest = util:base64Encode(concatRequest);
        json updateJSONRequest = {"message":{"raw":encodedRequest}};
        string updatePath = "/v1/users/" + userId + "/drafts/" + draftId;
        request.setHeader("Content-Type", "Application/json");
        request.setJsonPayload(updateJSONRequest);
        response, e = gmailEP.put(updatePath, request);
        int statusCode = response.statusCode;
        println("Status code: " + statusCode);
        json updateJSONResponse = response.getJsonPayload();

        if (statusCode == 200) {
            println(updateJSONResponse.toString());
            updateResponse, _ = <Draft>updateJSONResponse;
        } else {
            errorResponse.errorMessage = updateJSONResponse.error;
        }
        return updateResponse, errorResponse;
    }

    @Description {value:"Delete a particular draft"}
    @Param {value:"draftId: Id of the draft to delete"}
    @Return {value:"response structs"}
    action deleteDraft (string draftId) (StatusCode, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        StatusCode deleteDraftResponse = {};
        string deleteDraftPath = "/v1/users/" + userId + "/drafts/" + draftId;
        response, e = gmailEP.delete(deleteDraftPath, request);
        int statusCode = response.statusCode;
        json deleteDraftJSONResponse = response.getJsonPayload();

        if (statusCode == 204) {
            println("Status code: " + statusCode);
            deleteDraftResponse, _ = <StatusCode>deleteDraftJSONResponse;
        } else {
            errorResponse.errorMessage = deleteDraftJSONResponse.error;
        }
        return deleteDraftResponse, errorResponse;
    }

    @Description {value:"Lists the drafts in the user's mailbox"}
    @Param {value:"listDrafts: It is a struct. Which contains all optional parameters (includeSpamTrash,maxResults,
    pageToken,q) to list drafts"}
    @Return {value:"response structs"}
    action listDrafts (DraftsListFilter listDrafts) (Drafts, Error) {
        http:OutRequest request = {};
        http:InResponse response = {};
        Drafts listDraftsResponse = {};
        string uriParams;
        string listDraftsPath = "/v1/users/" + userId + "/drafts";

        if (listDrafts != null) {
            string includeSpamTrash = listDrafts.includeSpamTrash;
            string maxResults = listDrafts.maxResults;
            string pageToken = listDrafts.pageToken;
            string q = listDrafts.q;

            if (includeSpamTrash != "") {
                uriParams = uriParams + "&includeSpamTrash=" + includeSpamTrash;
            }

            if (maxResults != "") {
                uriParams = uriParams + "&maxResults=" + maxResults;
            }

            if (pageToken != "") {
                uriParams = uriParams + "&pageToken=" + pageToken;
            }

            if (q != "") {
                uriParams = uriParams + "&q=" + q;
            }
        }
        if (uriParams != "") {
            listDraftsPath = listDraftsPath + "?" + uriParams.subString(1, uriParams.length());
        }
        response, e = gmailEP.get(listDraftsPath, request);
        int statusCode = response.statusCode;
        json listDraftsJSONResponse = response.getJsonPayload();

        if (statusCode == 200) {
            println(listDraftsJSONResponse.toString());
            listDraftsResponse, _ = <Drafts>listDraftsJSONResponse;
        } else {
            errorResponse.errorMessage = listDraftsJSONResponse.error;
        }
        return listDraftsResponse, errorResponse;
    }
}