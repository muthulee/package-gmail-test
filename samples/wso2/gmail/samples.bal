package samples.wso2.gmail;

import wso2.gmail;
import ballerina.io;

function main (string[] args) {
    endpoint<gmail:ClientConnector> gmailConnector {
        create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);
    }

    gmail:Error e = {};

    if (args[0] == "getUserProfile") {
        io:println("-----Calling getUserProfile action-----");
        gmail:UserProfile gmailResponse = {};
        gmailResponse, e = gmailConnector.getUserProfile();
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "sendMail") {
        io:println("-----Calling sendMail action-----");
        gmail:GmailAPI gmailResponse = {};
        gmail:Message sendEmail = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"sendMail"};
        gmailResponse, e = gmailConnector.sendEmail(sendEmail);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "createDraft") {
        io:println("-----Calling createDraft action-----");
        gmail:Draft gmailResponse = {};
        gmail:Message createDraft = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"createDraft"};
        gmailResponse, e = gmailConnector.createDraft(createDraft);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "update") {
        io:println("-----Calling update action-----");
        gmail:Draft gmailResponse = {};
        gmail:Message update = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"update"};
        string draftId = args[6];
        gmailResponse, e = gmailConnector.update(draftId, update);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "deleteDraft") {
        io:println("-----Calling deleteDraft action-----");
        gmail:StatusCode gmailResponse = {};
        string draftId = args[6];
        gmailResponse, e = gmailConnector.deleteDraft(draftId);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "listDrafts") {
        io:println("-----Calling listDrafts action-----");
        gmail:Drafts gmailResponse = {};
        gmail:DraftsListFilter listDrafts = {maxResults:"3"};
        gmailResponse, e = gmailConnector.listDrafts(listDrafts);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    }
}